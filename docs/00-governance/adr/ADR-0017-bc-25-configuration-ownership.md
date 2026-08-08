# ADR-0017 — `BC-25` Configuration is platform-owned and receives `PRD-023`

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-04 |
| **Date** | 2026-08-04 |
| **Deciders** | Architecture Review Board, acting through the Architecture Owner and Product Owner roles defined in `PRD_OWNERSHIP_MODEL.md` §2.2 |
| **Supersedes** | — |
| **Amends** | `ADR-0013` §7 — settles the question that ADR deliberately left open. **No ranked document is amended by this ADR.** `PRD_REGISTRY.md`, `PRD_OWNERSHIP_MODEL.md` and `PRD_GAP_ANALYSIS.md` are updated, and all three are **unranked** — absent from `DOCUMENTATION_BASELINE.md` §4 |
| **Amended by** | — |
| **Baseline** | `BASELINE-2026-08-04-B` — not caused by this ADR; it registers a `PLANNED` document and changes no specification |
| **Related** | `ADR-0013` §7, §7.1 · `PGA-11` · `MASTER_PRD.md` §8 **module 18** · `PRD_REGISTRY.md` §4.3 (`PRD-022` precedent), §4.4 · BC Map line 134, `E-19` · `LCFG-1`…`LCFG-13` |

> ✅ **ACCEPTED 2026-08-04.**
>
> **The answer is option B: `BC-25` requires a dedicated PRD — `PRD-023` Settings & Configuration.**
>
> This is **not** inventing a PRD to fill a gap. The Master PRD — the Rank 1 document — already names *Settings &
> Configuration* as **product module 18** with `BC-25` as its context and **V1** as its scope. The module exists in
> the governing specification; what was missing was its entry in the PRD register. Registering it applies the
> mechanism `PRD_REGISTRY.md` §4.3 established for `PRD-022` one row earlier in the same table.

---

## 1. The question

`ADR-0013` established that a capability context is owned by its platform, not by the domain that consumes it. That
left `BC-25` Configuration without an owner: the Library PRD's header claimed it, `ADR-0013` removed that claim, and
no other PRD existed to receive it. `ADR-0013` §7 recorded the gap and **declined to resolve it**, on the explicit
grounds that *"inventing one here would exceed this ADR's scope."*

The Governance Closure Phase poses the question in three parts. Answering it required determining which of the
following is true:

| | Option | |
|---|---|---|
| **A** | `BC-25` is intentionally platform-owned and needs no PRD | ❌ Rejected — §4 |
| **B** | `BC-25` requires a dedicated PRD | ✅ **Chosen** — §3 |
| **C** | Another existing bounded context legitimately owns it | ❌ Rejected — §4 |

---

## 2. Evidence

Established from primary sources, not from the gap analysis.

### 2.1 The decisive fact — `BC-25` is a named V1 product module at Rank 1

`MASTER_PRD.md` §8 *Core Product Modules*, line 170, verbatim:

```
| 18 | Settings & Configuration | `BC-25` Configuration | `[GENERIC]` | V1 |
```

This is **Rank 1**, the highest authority in the precedence table. It names the module, binds it to `BC-25`,
classifies it `[GENERIC]` and scopes it **V1**.

### 2.2 Why the earlier analysis missed it

Both `ADR-0013` §7 and `PRD_GAP_ANALYSIS.md` derived their PRD candidates from two lists:

- Master PRD **§31** *Linked Documents* — the nine named PRDs
- Master PRD **§8.1** — the eight contexts that *"carry product-visible obligations but had no module entry"*

`BC-25` is in **neither**. Critically, it is absent from §8.1 **because it *does* have a module entry** — §8.1 lists
contexts *"absent from the v1.0 module list"*, and `BC-25` is *in* that list, at row 18. The exclusion that made
`BC-25` look unregistered is the same fact that proves it is a module.

**`BC-25` was never outside the Master PRD. It was outside the two lists this register happened to derive from.**

### 2.3 The precedent is already set, one row earlier

`PRD_REGISTRY.md` §4.3 registers `PRD-022` SaaS Billing on grounds recorded in the register itself:

```
| `PRD-022` | SaaS Billing | BC-20 Subscription & Billing | [GENERIC] | V1 | PLANNED | Master PRD §8 module 17; …
```

`BC-20` is **module 17**. `BC-25` is **module 18** — the very next row of the same table, same classification
`[GENERIC]`, same scope V1, discovered by the same method. Registering `PRD-023` on identical grounds is the
*consistent* application of an existing rule. Refusing to would mean the register treats two adjacent rows of one
Rank 1 table by different standards.

### 2.4 Classification cannot decide it

`BC-25` is `[GENERIC]`, shared with `BC-19`, `BC-21`, `BC-22`, `BC-23`, `BC-24`, `BC-29`, `BC-30` and `BC-31` —
**every one of which has a registered PRD.** So `[GENERIC]` is not a reason to withhold one.

### 2.5 `BC-25` owns state, and has consumers with requirements

- BC Map line 134: `BC-25` *"Owns settings hierarchy, feature flags, branding values, secret **references**."*
  A context that owns state and has an owner needs a document specifying its behaviour.
- Edge **`E-19`**: *"All contexts | `BC-25` Configuration | `CF` | Sync port | Typed config accessors; **no raw
  string lookups in domain code**"* — a platform-wide constraint on every context, currently specified nowhere but
  this one table cell.
- Thirteen configurables `LCFG-1`…`LCFG-13` currently live in the **Library** PRD (`LCFG-1` Time Zone, `LCFG-2`
  Language, `LCFG-3` Currency, with `LCFG-11`…`13` in §14B). Under `ADR-0013` the Library PRD consumes `BC-25`
  rather than owning it, so the **hierarchy, precedence and override semantics** those values resolve through have
  no owning document.
- `platform/configuration` exists at **rank 3** in `tool/module_dependencies.yaml`'s `ranks:` table with **no
  module block** — declared, unspecified, unimplemented.

---

## 3. Decision

**Option B. `BC-25` Configuration is owned by `PRD-023` Settings & Configuration**, registered `PLANNED`.

| Field | Value |
|---|---|
| Identifier | **`PRD-023`** |
| Title | **Settings & Configuration** |
| Owns | **`BC-25`** Configuration |
| Classification | `[GENERIC]` |
| Scope | **V1** |
| Status | `PLANNED` |
| Module | `platform/configuration`, **rank 3** |
| Authority | `MASTER_PRD.md` §8 module 18; registered per `PRD_REGISTRY.md` §4.3 precedent |

### 3.1 What `PRD-023` will own when written

Scope is fixed **now** so the registration is not an open-ended reservation:

1. The **settings hierarchy** and its precedence order — platform default → tenant → library → branch → user.
2. **Feature flags** — definition, evaluation, rollout, and the boundary against `BC-21` Entitlement (a flag says
   *is this on*; an entitlement says *is this paid for*).
3. **Branding values** — the values only. The *images* remain `FileRef`s issued by `BC-29`, and `LibraryBranding`
   as an aggregate stays with `PRD-002` per `ADR-0013` §5.
4. **Secret references** — references only. Never secret material; that is `SECURITY`.
5. The **`E-19` typed-accessor contract** — the mechanism enforcing *no raw string lookups in domain code*.
6. The **`LCFG-*` resolution semantics** — how a configurable's effective value is determined. The `LCFG-1`…`LCFG-13`
   *definitions* stay in the Library PRD; `PRD-023` owns the resolution machinery, not the value list.

### 3.2 What `PRD-023` explicitly does **not** own

- No `LIB-*`, `LCFG-*`, `SID-*`, `SCFG-*` or `ICFG-*` requirement moves into it. **This ADR moves no requirement.**
- Not secret material (`SECURITY`), not entitlement decisions (`BC-21`), not tenancy structure (`BC-19`, `PRD-013`),
  not file bytes (`BC-29`, `PRD-017`).

### 3.3 What this ADR does *not* do

It **registers** a document; it does not write one. `PRD-023` is `PLANNED`. No requirement is created, and
`PRD_REGISTRY.md` §8's numbering rules apply — `023` is next in sequence and is never reused.

---

## 4. Options considered

| # | Option | Verdict |
|---|---|---|
| **B** | Dedicated `PRD-023` | ✅ **Chosen.** Master PRD §8 names the module; §4.3 supplies the mechanism |
| **A** | Platform-owned, no PRD needed | ❌ **Rejected.** Contradicts Rank 1: a V1 product module cannot have no specification. Also fails the Single Owner Rule test in spirit — a context that owns state with no owning document is exactly the condition `PGA-11` exists to flag. And `SID-4.56` applies: an unspecified `E-19` contract cannot be checked, so it would be *unmet*, not satisfied by intent |
| **C1** | Fold into `PRD-013` Tenancy (`ADR-0013` §7 option 2) | ❌ **Rejected.** Settings resolve across **five** scopes, only one of which is the tenant; user-level preference and platform default are outside `BC-19` entirely. Merging them would make `PRD-013` own a hierarchy whose top and bottom levels are not tenancy concerns, and would put two contexts in one PRD — the precise defect Master PRD §8 *Correction 2* corrects for Security & Automation |
| **C2** | Fold into `PRD-002` Library — i.e. keep the status quo | ❌ **Rejected.** Directly contradicts `ADR-0013`, which this ADR amends rather than reverses. Configuration is consumed by *all* contexts (`E-19`), not just Library |
| **C3** | Fold into a SECURITY PRD, since it holds secret references | ❌ **Rejected.** `BC-25` holds *references*; SECURITY holds material. Merging them would put branding colours and feature flags behind a security boundary |
| **D** | Defer the decision again | ❌ **Rejected.** The closure phase exists to end deferral, and the evidence in §2 is sufficient and already in the repository |

---

## 5. Consequences

### 5.1 Positive

- **`PGA-11` closes completely.** Contested contexts: **3 → 0**.
- `ADR-0013`'s only open question is settled, so that ADR is fully executed rather than partially.
- The registry stops recording `BC-25` as *"Covered — `PRD-002` owns `BC-25`"*, which `ADR-0013` made false.
- `E-19` and the `LCFG-*` resolution semantics acquire a named owner.
- `platform/configuration` (rank 3) gains the specification its manifest entry has been waiting for.

### 5.2 Negative / costs

- **A 24th PRD, and a 20th unwritten one.** The backlog grows before it shrinks. Accepted: the alternative is a V1
  product module with no specification, which is a worse defect than a registered gap.
- `PRD_REGISTRY.md` §7's *"Missing V1 PRDs"* count rises from 19 to **20**. This is a **truer** number, not a
  worse one — the module was always missing, and was previously mis-recorded as covered.

### 5.3 Risks

| Risk | Severity | Mitigation |
|---|---|---|
| Read as inventing a PRD to fill a gap — the thing explicitly prohibited | **High** | §2.1 and §2.3 are the answer: Rank 1 already names the module; §4.3 already established the mechanism. No requirement is created (§3.3) |
| `PRD-023` grows to absorb entitlement or security scope | Medium | §3.1 fixes the scope and §3.2 fixes the exclusions **before** the document is written |
| `LCFG-*` requirements silently migrate out of the Library PRD | Medium | §3.2: no requirement moves. Any future migration needs its own ADR |
| The number `023` collides with a future reservation | Low | `PRD_REGISTRY.md` §8 rule 1: numbers are sequential and never reused. `PRD-023` is allocated here and now |

---

## 6. Traceability impact

| Register | Impact |
|---|---|
| `LIB-*`, `LCFG-*`, `SID-*`, `SCFG-*`, `ICFG-*`, `MP-*` | **None.** No requirement created, moved or reworded |
| `BC-01`…`BC-31` | **None.** No context added or reclassified; `BC-25` gains an *owner*, not a change |
| `E-01`…`E-26` | **None.** `E-19` gains an owning document, not an amendment |
| `PRD-000`…`PRD-023` | **One registration.** 23 → **24** registered |
| `X-*`, `L1`…`L5` | **None.** No exception added |
| `module_dependencies.yaml` | **None.** `platform/configuration: 3` already exists |
| `PGA-01`…`PGA-11` | `PGA-11` **closed** |

---

## 7. Compliance

| # | Check | Expected |
|---|---|---|
| 1 | `PRD_REGISTRY.md` §6 | Exactly one context-owner for `BC-25` → `PRD-023` |
| 2 | `PRD_REGISTRY.md` §7 contested count | **0** |
| 3 | Registered-PRD count = owned-context count | **24 = 24** |
| 4 | Master PRD | **Unmodified.** §8 module 18 already supports this decision; nothing to add |
| 5 | `dart run tool/check_module_boundaries.dart` | Unchanged — no code, no manifest change |

---

## 8. Migration requirements — **executed 2026-08-04**

| # | Change | Document | Rank | Executed |
|---|---|---|---|---|
| **M1** | Register `PRD-023` Settings & Configuration; correct §4.4's *"Covered — `PRD-002` owns `BC-25`"*; update §6 owner row, §7 counts | `PRD_REGISTRY.md` | unranked | ✅ |
| **M2** | Assign `BC-25` → `PRD-023`; remove from the §4.4 contested table | `PRD_OWNERSHIP_MODEL.md` | unranked | ✅ |
| **M3** | Close `PGA-11` for `BC-25` | `PRD_GAP_ANALYSIS.md` | unranked | ✅ |
| **M4** | Register this ADR | `ADR-INDEX.md` | — | ✅ |

**Not required, and deliberately not done:** no change to `MASTER_PRD.md` (Rank 1 — it already names module 18 and
is *evidence* for this decision, not a subject of it), the BC Map, the Dependency Matrix, any module PRD,
`module_dependencies.yaml`, or any `lib/` source file. **No new baseline identifier is caused by this ADR.**

---

## 9. Change history

| Date | Change |
|---|---|
| 2026-08-04 | Created and **Accepted** in the Governance Closure Phase. Resolves the question `ADR-0013` §7 left open, and does so on **grounds that ADR did not have**: the acceptance review read `MASTER_PRD.md` §8 **module 18** and the `PRD-022`/§4.3 precedent, which together show `BC-25` was already a named V1 product module at Rank 1. Both options `ADR-0013` §7 offered therefore rested on an incomplete premise — recorded in `ADR-0013` §7.1. Six options considered, five rejected, including three distinct fold-in candidates. **Decision B.** One PRD registered `PLANNED`; **zero requirements created or moved**; contested contexts 3 → 0. |
