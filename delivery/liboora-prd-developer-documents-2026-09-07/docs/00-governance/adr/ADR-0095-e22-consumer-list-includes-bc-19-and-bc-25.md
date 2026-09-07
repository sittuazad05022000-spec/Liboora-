# ADR-0095 — Edge `E-22` must list `BC-19` and `BC-25`, the two contexts that hold a `FileRef` for library gallery and branding media

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-02 |
| **Date** | 2026-09-02 |
| **Deciders** | **Architecture Owner** — the role `PRD_OWNERSHIP_MODEL.md` §2.2/§2.3 (**L85**, **L102**) assigns *"boundaries, ranks, permitted edges"*, and **L284** records as the *only* approving body for a Rank 1–5 document change. ⭐ The role is here **filled for this act only** by **direct conferral from the human principal of this engagement**, in the same manner and with the same disclosure as `ADR-0032` §5.2, `ADR-0033` §7.2, `ADR-0036` §8.2, `ADR-0080` §5, `ADR-0083`, `ADR-0091` and `ADR-0093`. ⛔ **No ARB quorum, attendee list, sign-off date or Security review is asserted.** ⛔ **No personal name is recorded** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 |
| **Authority instrument** | `PRD-021C_OWNER_DECISION_FORM.md` §3 — decision **`XPC-OD-003`**, option **C** (*admit **BOTH** `BC-19` **and** `BC-25`*), authorized explicitly by the human principal. ⭐ Option **C** was selected over the narrower options **A** (`BC-19` only) and **B** (`BC-25` only); §3 of this ADR records why **both** are independently necessary, so option C is not a convenience union but the measured answer |
| **Amends** | `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` (Rank 4) — §7.3, edge **`E-22`**, the **Downstream/consumer cell only**. ⛔ **No edge added, no edge removed, no mode changed (`CF` stands), no mechanism changed (*Sync port* stands), no contract semantics changed, no context reclassified, no aggregate moved, no invariant altered, no tenancy mode touched.** Executed, see §7 |
| **Baseline** | **No baseline re-issue.** BC Map is **Rank 4**; `DOCUMENTATION_BASELINE.md` §7 step 4 moves the baseline identifier *"only when a Rank 1–3 document changes version"*. `ADR-0016` and `ADR-0055` recorded the identical exemption for **the identical cell**|
| **Closes** | **`XPC-OD-003`** — `PRD-021C` C3's gallery/branding media blocker. See §5 |
| **Does NOT close** | `XPC-OD-004`, `XPC-OD-005`, `XPC-OD-006` — **all three remain OPEN and are untouched.** ⛔ Confers **no** lifecycle stage on `PRD-021C`; verifies **no** code; closes **no** acceptance criterion; does **not** make any gallery image publishable — publication remains a `BC-19`/§14A.6 choice |
| **Related** | **`ADR-0016`** (`E-22` gains `BC-10`) and **`ADR-0055`** (`E-22` gains `BC-12`) — the two prior one-cell amendments to **this exact cell**, whose method and per-context necessity test this ADR follows · `ADR-0093` (the sibling `E-21` amendment executed in the same commit) · `ADR-0083` §4.1 `E-29` (the *"reference only — never bytes, never a raw storage path… does NOT become a second media owner"*
formulation reused below) · BC Map **L292** (the governing rule), **L331** (`E-22`), **L128** (`BC-19`), **L134** (`BC-25`), **L138** (`BC-29`), **L490** (tenant partitioning of files) · `AR-1` (*"Gallery → `BC-29`"*) · `PRD-021C` C3 `LPP-FR-011`, `LPP-FR-014`…`LPP-FR-017` |

> ✅ **ACCEPTED 2026-09-02. The migration in §7 has been executed.**
>
> This is the **third** amendment to `E-22`'s consumer cell and the **fourth** instance of the defect class
> `ADR-0016` opened. ⭐ It is also the **first** to admit **two** contexts at once — and §3 therefore tests
> necessity **separately for each**, exactly as `ADR-0055` §3 did when it admitted `BC-12` and **refused**
> `BC-11` and `BC-13` in the same act.

---

## 1. Context

### 1.1 The rule that makes this a defect, and that also forbids fixing it quietly

Bounded Context Map §7, **line 292**:

> *"Every edge that crosses a context boundary in V1. If an edge is not in this table, it **does not exist** and adding it requires an ADR."*

`ADR-0055` §1.1 stated the consequence that applies again here:

> *"The rule cuts both ways… it is why this ADR exists — the consumer cannot simply be typed into the cell."*

### 1.2 The measured omission

`E-22` as it stood at BC Map **L331** (abridged to the two cells that matter):

```
| E-22 | BC-01, BC-10, BC-12, BC-14 | BC-29 File & Media | CF | Sync port | Domain holds a FileRef, never bytes or a raw storage path. BC-10 added by ADR-0016 … BC-12 added by ADR-0055 … BC-11 and BC-13 are deliberately NOT consumers … |
```

**`BC-19` and `BC-25` are both absent.** Yet two Rank 3/4 obligations already require each of them to hold a
`FileRef`:

| Obligation | Measured source | Which context it lands on |
|---|---|---|
| Gallery is a **publishable** public-profile field, and `AR-1` routes it: *"Gallery → `BC-29`"* | `14A-Library-Discovery-And-Enrollment.md` §14A.5 (**FROZEN**); `ARCHITECTURE_RULINGS.md` `AR-1` **L23** | **`BC-19`** — it *"Owns the tenant (library organisation) record"* (**L128**), and the gallery is that organisation's own media |
| Logo **MUST** be read from **`BC-25` branding values** | `PRD-021C` C3 **`LPP-FR-011`** | **`BC-25`** — it *"Owns settings hierarchy, feature flags, **branding values**, secret *references*"* (**L134**) |

So C3's `LPP-FR-014`…`LPP-FR-017` (gallery) and `LPP-FR-011` (logo) each depend on an edge that §7's own rule
declares **does not exist**. C3 recorded this rather than assuming it away — its §6 heading reads
*"⚠ CONDITIONAL on `XPC-OD-003`"* and `LPP-FR-014` is marked *"⚠ **CONDITIONAL**"*.

### 1.3 ⭐ Why the fix is a consumer cell and not new media infrastructure

The tempting alternatives were both measured and rejected in §6. The decisive fact is that **`BC-29` already
owns everything required**: *"upload, virus scan, thumbnailing, signed URLs, storage abstraction"* (**L138**).
Neither `BC-19` nor `BC-25` needs to acquire a single one of those capabilities. Each needs exactly one thing —
**permission to hold a `FileRef` issued by `BC-29`** — and that permission is the cell this ADR amends.

### 1.4 The prior refusals were correct, and are not reversed

`ADR-0055` §3 **refused** `BC-11` and `BC-13` admission to this same cell on a per-context necessity test.
That refusal stands unamended: neither context is added here, and §3 below applies the same test rather
than a laxer one. ⭐ **The test is the point of the precedent, not the outcome.**

---

## 2. Decision

The **Downstream (consumer)** cell of edge `E-22` in Bounded Context Map §7.3 is amended:

| | Value |
|---|---|
| **From** | `BC-01, BC-10, BC-12, BC-14` |
| **To** | `BC-01, BC-10, BC-12, BC-14, BC-19, BC-25` |

**Everything else about `E-22` is preserved verbatim:**

- Provider: **`BC-29` File & Media** — unchanged, and it remains the **sole** media infrastructure owner.
- Pattern: **`CF`** (Conformist) — unchanged. `BC-19` and `BC-25` conform to `BC-29`'s contract; they do not
  negotiate it and do not shape it.
- Mechanism: **Sync port** — unchanged. No event is minted by this ADR.
- Contract: *"Domain holds a `FileRef`, never bytes or a raw storage path"* — **unchanged, and it binds the two
  new consumers on exactly the terms it binds the existing four.**

---

## 3. ⭐ Necessity tested **separately per context** — the `ADR-0055` §3 discipline

`ADR-0055` §3 established that this cell is amended **per context**, never per module, so that *"the map stays
context-grained where the manifest is module-grained"*. Option **C** admits two contexts, so the test is run
twice and the two results are independent.

### 3.1 `BC-19` Tenancy — ADMITTED

| Test | Result |
|---|---|
| Does it own an entity whose media is published? | ✅ **Yes.** *"Owns the tenant (library organisation) record"* (**L128**). The public profile **is** a rendering of that record; the gallery is that organisation's own photographs of its own premises |
| Does a Rank 1–4 obligation require it to hold a `FileRef`? | ✅ **Yes.** §14A.5 (FROZEN) lists Gallery as publishable; `AR-1` **L23** routes *"Gallery → `BC-29`"*. Something must hold the reference, and only `BC-19` owns the entity |
| Does it hold the bytes? | ⛔ **No, and it must not.** It holds a `FileRef` only. `BC-29` holds the bytes |
| Does an alternative lawful path already exist? | ⛔ **No.** `BC-19` appears in **no** other edge as a `BC-29` consumer; `E-18` and `E-19` are *inbound* to the capability tier |
| Is a **new edge** required? | ⛔ **No** — and this is why no new edge is minted. `E-22` already carries this exact relationship for four contexts under the exact constraint required |

### 3.2 `BC-25` Configuration — ADMITTED, on an independent ground

| Test | Result |
|---|---|
| Does it own an entity whose media is published? | ✅ **Yes, and the map already says so.** **L134** reads *"Owns settings hierarchy, feature flags, **branding values**, secret *references*."* A logo **is** a branding value |
| Does a Rank 1–4 obligation require it to hold a `FileRef`? | ✅ **Yes.** `PRD-021C` C3 **`LPP-FR-011`** — *"Logo **MUST** be read from `BC-25` branding values"* — and C3 is forbidden from holding bytes itself (`LPP-XC-004`, `LPP-FR-014`) |
| Does it hold the bytes? | ⛔ **No.** ⭐ **L134**'s own phrasing already anticipates this shape: `BC-25` owns *"secret **references**"*, not secrets. A `FileRef` is the same shape — a reference to something another context holds |
| Does an alternative lawful path already exist? | ⛔ **No.** `E-19` runs `All contexts → BC-25`: it is `BC-25` as **provider**, not as a consumer of `BC-29` |
| Is a **new edge** required? | ⛔ **No.** Same reasoning as §3.1 |

### 3.3 ⭐ Why this is two admissions and not one

The two grounds are **not** interchangeable, which is why option **C** rather than **A** or **B** is the correct
answer rather than merely the widest one:

- Admitting only **`BC-19`** would leave `LPP-FR-011`'s logo path unlawful, and would invite the defect of
  routing branding media through the tenant record — which would make `BC-19` a second branding owner and
  contradict **L134**.
- Admitting only **`BC-25`** would leave the §14A.5 gallery unlawful, and would invite the opposite defect of
  filing a library's premises photographs as *"configuration"* — which they are not.

Each context is admitted **for its own field set and for no other**. ⛔ Nothing here permits `BC-25` to hold
gallery media, and nothing permits `BC-19` to hold branding values. The existing ownership split at **L128**
and **L134** is the boundary, and it is unchanged.

### 3.4 Contexts tested and **NOT** admitted

| Context | Why not |
|---|---|
| `BC-11` Social Graph | ⛔ Refused by `ADR-0055` §3; that refusal stands. It answers eligibility as a boolean and never holds a `FileRef` |
| `BC-13` Trust & Safety | ⛔ Refused by `ADR-0055` §3; that refusal stands. It reaches media outbound by `E-14` |
| `BC-23` Search Indexing | ⛔ **Not admitted.** An index entry may carry a `FileRef` **value** received through `E-21` from its source context; that is data flowing along a declared edge, not `BC-23` calling `BC-29` |
| `BC-26` Analytics Read Model | ⛔ **Not admitted.** Nothing in `XPC-OD-007A`/`B` requires `BC-26` to hold media |
| `PRD-021C` C1/C2/C3/C4 | ⛔ **Not contexts at all** (`AR-1`, module 19 is *"not a context"*). They compose reads; they cannot be edge participants |

---

## 4. Ownership boundaries — preserved, stated as invariants

| # | Invariant | Status after this ADR |
|---|---|---|
| 1 | **`BC-29` File & Media is the sole media infrastructure owner** — upload, virus scan, thumbnailing, signed URLs, storage abstraction (**L138**) | ✅ **Unchanged.** Not one of those five capabilities moves |
| 2 | **A `FileRef` is a reference, never bytes and never a raw storage path** | ✅ **Unchanged**, and now binding on six consumers instead of four |
| 3 | **No source context owns media bytes** | ✅ **Unchanged.** `BC-19` and `BC-25` hold references only |
| 4 | ⛔ **No duplicate media infrastructure is created** | ✅ **Guaranteed by construction** — the amendment *avoids* new infrastructure by reusing the existing edge. Zero new storage, scanning, thumbnailing or URL-signing capability exists anywhere after this ADR |
| 5 | **Files are tenant-partitioned** — *"Indices, caches, projections, prompts, embeddings and files are **all** tenant-partitioned"* (**L490**) | ✅ **Unchanged.** Both new consumers are in the `BC-19→31` capability tier that **L490** governs, so they inherit the rule rather than needing an exception |
| 6 | **Context count 31 (23 in V1); edge set `E-01`…`E-26`, `E-28`, `E-29`, plus `E-30` minted by `ADR-0096`; `E-27` permanently vacant** | ✅ **This ADR changes none of them.** It adds **0** edges and **0** contexts |
| 7 | **Publication is not authorised by this ADR** | ✅ A lawful *carriage* path is not a publication decision. §14A.6 and `LPP-FR-015` still gate what becomes public, and `LPP-FR-016` still requires a completed `BC-29` virus scan |

---

## 5. What this closes, and what it explicitly does not

**Closes `XPC-OD-003`.** C3's `LPP-FR-014`…`LPP-FR-017` and `LPP-FR-011` now rest on a declared edge.

⛔ **Does not close, and does not touch:**

- `XPC-OD-004`, `XPC-OD-005`, `XPC-OD-006` — **all three remain OPEN.** They are not mentioned in the
  authority instrument and are therefore outside this ADR's authority entirely.
- `XPC-OD-001` (closed by `ADR-0093`), `XPC-OD-002` (closed by `ADR-0094`), `XPC-OD-007A` (`ADR-0096`),
  `XPC-OD-007B` (`ADR-0097`) — separate acts, separate authority lines.

⛔ **Confers no lifecycle stage.** `PRD-021C` and every part of it remain **DRAFT at Stage 2**, **NOT FROZEN**,
**NOT APPROVED**, **NOT BASELINED**. Stage 3 has **not** been entered and no alignment record exists.

---

## 6. Alternatives considered

| Option | Verdict |
|---|---|
| **A** — admit `BC-19` only | ⛔ **Rejected by the owner, and independently incorrect.** Leaves `LPP-FR-011`'s logo path unlawful, or forces branding media through `BC-19` against **L134** |
| **B** — admit `BC-25` only | ⛔ **Rejected by the owner, and independently incorrect.** Leaves the §14A.5 gallery unlawful, or misfiles premises photographs as configuration |
| **C** — admit **both**, one cell | ✅ **SELECTED.** Each admission carries its own necessity proof (§3.1, §3.2). Smallest change that makes both obligations lawful: **1 cell, 0 new edges, 0 new contexts, 0 new infrastructure** |
| **D** — mint a new edge for library media | ⛔ **Rejected.** A second `→ BC-29` edge with the same pattern, mechanism and constraint as `E-22` would be a duplicate of `E-22`. It would also cost an edge number and a §7 insertion, against the `ADR-0079` §8.5 measurement |
| **E** — let C3 hold the media | ⛔ **Rejected.** C3 is *"NOT a bounded context"* and `LPP-XC-004` already forbids it. This would create the duplicate media infrastructure the authority instrument prohibits |
| **F** — widen the whole capability tier `BC-19`…`BC-31` | ⛔ **Rejected.** Exactly the module-grained shortcut `ADR-0055` §3 refused. Necessity is tested per context, and `BC-26`, `BC-23`, `BC-30` and others have **no** measured need |

---

## 7. Migration requirements — executed

| # | Change | Document | Rank | Executed |
|---|---|---|---|---|
| **M1** | `E-22` **consumer cell** `BC-01, BC-10, BC-12, BC-14` → `BC-01, BC-10, BC-12, BC-14, BC-19, BC-25`, with this ADR cited in the contract cell alongside `ADR-0016` and `ADR-0055` | `LIBOORA_BOUNDED_CONTEXT_MAP.md` §7.3 **L331** | 4 | ✅ |
| **M2** | Header `Version` **v1.10 → v1.11**; header count cell restated; one changelog row added | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | 4 | ✅ |
| **M3** | Register `ADR-0095` | `docs/00-governance/adr/ADR-INDEX.md` | — | ✅ |
| **M4** | `XPC-OD-003` marked **RESOLVED**; C3 §6's conditional markers lifted for `LPP-FR-014`…`LPP-FR-017` | `PRD-021C` C0, C3 | — | ✅ |

**Not required:** no baseline re-issue (Rank 4, §7 step 4); no Rank 1–3 document changed; **no `lib/` source
file touched**; no `tool/module_dependencies.yaml` change — `ADR-0055` **L**'s finding that
`domain/social → platform/services:files` was *already* granted shows the manifest is module-grained and
already permissive; the **map** was the incomplete record, and only the map is amended.

---

## 8. Consequences

**Positive**

- Two frozen/Rank-4 obligations (§14A.5 Gallery, `AR-1` *"Gallery → `BC-29`"*) and one C3 requirement
  (`LPP-FR-011`) become lawfully implementable.
- **19 of C3's 44** requirements lose one of their two blockers; the gallery block of four is fully unblocked.
- ⭐ The `ADR-0016`/`ADR-0055` defect class is now closed for **six** contexts on a single edge, with the
  per-context test applied every time and **two** contexts still deliberately refused.

**Negative — accepted**

- `E-22`'s consumer cell now lists six contexts and its contract cell three ADRs. Verbosity is the accepted
  cost of a context-grained register; the alternative (a module-grained rule) was refused by `ADR-0055` §3.
- Two more contexts can now obtain signed URLs, widening the surface over which `BC-29`'s access control must
  hold. ⭐ This is **not a new risk class** — **L490** already governs it for the whole capability tier — but it
  is disclosed rather than left implicit.

**Not a consequence**

- ⛔ `BC-19` does **not** become a media owner. ⛔ `BC-25` does **not** become a media owner.
- ⛔ No gallery image becomes publishable. ⛔ No virus-scan requirement is relaxed.
- ⛔ No context is reclassified, re-ranked or re-clustered.
- ⛔ No event is minted. ⛔ No edge is minted **by this ADR**.

---

## 9. Compliance

- ⛔ This ADR does **not** rewrite `ADR-0016`, `ADR-0055` or any historical ADR. Both are cited and both
  remain `Accepted` and unamended.
- ⛔ It does **not** consume `ADR-0088`, `ADR-0089` or `ADR-0090` — **reserved and unwritten** for `PRD-021B`
  `FOD-1`/`FOD-2` per `ADR-0091` **L315**. Verified absent by exact filename before this number was taken.
- ⛔ It does **not** amend `14A-Library-Discovery-And-Enrollment.md` (**FROZEN**), `Library_PRD_v1.md`
  (**FROZEN**), `14B-Public-Library-Preview.md`, `PRD_REGISTRY.md`, or any `PRD-021B` artefact.
- ⛔ It does **not** enter Stage 3, create a Stage-3 Alignment Record, claim architecture alignment `PASS`,
  mint an `IMPL-*` identifier, write application code, freeze, baseline, rank or approve `PRD-021C`.
- ⛔ It does **not** resolve `XPC-OD-004`, `XPC-OD-005` or `XPC-OD-006`.
- ⛔ It does **not** create a bounded context, an aggregate, an invariant, an event or an edge.
- ⛔ It does **not** create duplicate media infrastructure — see §4 invariant 4.
- ⛔ It does **not** admit `BC-11`, `BC-13`, `BC-23`, `BC-26` or any `PRD-021C` part to `E-22`.
- ⛔ It does **not** grant `BC-25` gallery media or `BC-19` branding values — §3.3.
