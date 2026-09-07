# ADR-0097 — `ProfileViews` is certified as a `BC-26` metric; `UniqueViewers` is deliberately NOT certified

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-02 |
| **Date** | 2026-09-02 |
| **Deciders** | **Product Owner** *(metric definition and product commitment)* **and Architecture Owner** *(the `BC-26` semantic-layer boundary)*, **jointly** — the decision is joint because `PRD-021C` C3 **L148** records `XPC-OD-007`'s owner as *"**Architecture Owner** (producer + edge) **+ Product Owner** (`PRD-009` metrics)"*, and this ADR discharges the metric half. ⭐ **Both** roles are here **filled for this act only** by **direct conferral from the human principal of this engagement**, in the same manner and with the same disclosure as `ADR-0032` §5.2, `ADR-0033` §7.2, `ADR-0036` §8.2, `ADR-0080` §5, `ADR-0083`, `ADR-0091`, `ADR-0093`, `ADR-0094`, `ADR-0095` and `ADR-0096`. ⛔ **No ARB quorum, attendee list, sign-off date, Security review or Privacy Owner review is asserted** — `PRD_OWNERSHIP_MODEL.md` **L509** records that *"no holder is appointed"* to the Privacy Owner role, and `XPC-CONF-013` records that vacancy. ⛔ **No personal name is recorded** — §7 rule 4 |
| **Authority instrument** | `PRD-021C_OWNER_DECISION_FORM.md` §5 — decision **`XPC-OD-007B`**, option **B** (*certify **ONLY** `ProfileViews`*), authorized explicitly by the human principal. ⭐ The instrument was **explicit in both directions**: *"Certify ONLY `ProfileViews`. Do NOT certify `UniqueViewers`."* §4 records why that asymmetry is architecturally coherent rather than an omission |
| **Amends** | ⛔ **Nothing is edited.** This ADR is **declaratory and constitutive**: it **defines** a metric under an authority (`BC-26`) that already exists, in the artefact class (an ADR) that `PRD_OWNERSHIP_MODEL.md` **L284** makes competent to do so. ⛔ **`PRD-009` is NOT created** and remains `PLANNED`. ⛔ **`PRD_REGISTRY.md` is byte-unchanged.** ⛔ **The BC Map is not amended by this ADR** — `BC-26`'s row (**L135**) and its `Projection` aggregate (**L385**) already grant it the metric/semantic layer, so no cell needs to move. See §6 |
| **Baseline** | **No baseline re-issue.** No Rank 1–3 document changes version; no document changes at all. `DOCUMENTATION_BASELINE.md` §7 step 4 |
| **Closes** | **`XPC-OD-007B`** — the metric-certification half of `PRD-021C` C3 §9A's blocker. Together with `ADR-0096` this closes `XPC-OD-007` entirely. See §7 |
| **Does NOT close** | `XPC-OD-004`, `XPC-OD-005`, `XPC-OD-006` — **all three remain OPEN and untouched.** ⛔ Does **not** resolve `XPC-CONF-013` (Privacy Owner **VACANT**). ⛔ Confers **no** lifecycle stage; verifies **no** code; closes **no** acceptance criterion |
| **Related** | `ADR-0096` (the producing event and edge `E-30`, on which this metric depends and whose payload boundary is the reason `UniqueViewers` cannot be certified) · `ADR-0094` (the sibling declaratory act, and the precedent for defining a contract without authoring its registered PRD) · BC Map **L135** (`BC-26` owns *"the metric/semantic layer"*), **L385** (`Projection` / `CertifiedMetric` / `ReadModel`, *"metric definitions single-sourced from the semantic layer"*), **L490** · `PRD_REGISTRY.md` **L246** (`PRD-009`, `PLANNED`) · `AR-3`, `AR-7` · §14A.5 *Internal Analytics* (**never-public**); `LIB-14B.22` · `PRD-021C` C3 `LPP-FR-035`…`LPP-FR-040`, `LPP-FR-044`, `LPP-XC-013` |

> ✅ **ACCEPTED 2026-09-02.**
>
> ⭐ **`ProfileViews` is the FIRST `CertifiedMetric` named anywhere in the repository.** Before this ADR,
> **L385** established the *class* `CertifiedMetric` as a member of `BC-26`'s `Projection` aggregate, but **no
> instance of it had ever been defined**. The six properties in §3 are therefore not paperwork — they are the
> first exercise of an authority the map granted and nothing had yet used.

---

## 1. Context

### 1.1 What C3 requires, and what it refuses to do itself

`PRD-021C` C3 §9A specifies the Owner Profile Engagement Summary — 👁️ **Profile Views** with a trend and a
**[View Analytics]** CTA — and is emphatic that it is **render-only**:

- `LPP-FR-035` — *"**Total Profile Views MUST** be read as a **`CertifiedMetric` of `BC-26`**. C3 **MUST NOT**
  count, increment, store, cache-as-source, aggregate, sample or re-derive it."*
- `LPP-FR-038` — *"C3 **MUST NOT** define the metric semantics — what constitutes a view, whether a bot is
  excluded, whether an owner's own visit counts, or the deduplication window."*
- `LPP-XC-013` — C3 does **not** *"Define, own or version any metric semantic."*

C3's own commentary states the reason plainly, and it is the reason this ADR exists rather than a C3 edit:

> *"A readout that defines its own metric semantics **is** a parallel analytics system, however small. Two
> surfaces that each decide independently whether a bot counts will disagree, and the owner will be shown
> *"1.2K"* on the profile and a different number in the analytics dashboard."*

### 1.2 The measured gap

| Fact | Measured |
|---|---|
| `BC-26` **owns** the metric/semantic layer and the `CertifiedMetric` concept | BC Map **L135**, **L385** — present, Rank 4, V1 |
| `PRD-009 Analytics & Reports` → `BC-26` is the **registered** home of the analytics product surface | `PRD_REGISTRY.md` **L246** — status **`PLANNED`** |
| `PRD-009` **exists on disk** | ⛔ **NO.** `find docs -iname "*PRD-009*"` → **nothing** |
| Any `CertifiedMetric` **instance** is defined anywhere | ⛔ **NO.** The class exists at **L385**; no instance had ever been named |

So the *owner* of the definition was named at Rank 4 while the *definition* did not exist. This is structurally
identical to `XPC-OD-002` (`PRD-015`, `BC-23`'s absent owner) and is resolved the same way — by defining the
contract in a competent artefact **under the existing owner's authority**, without authoring the absent PRD.

---

## 2. Decision

Two clauses, in opposite directions.

1. ✅ **`ProfileViews` is CERTIFIED** as a `CertifiedMetric` of **`BC-26` Analytics Read Model**, with the six
   semantic properties fixed in **§3**. `BC-26` is its sole definitional authority.
2. ⛔ **`UniqueViewers` is NOT CERTIFIED.** It has **no** authoritative definition, is **not** a
   `CertifiedMetric`, and **MUST NOT** be rendered. Its treatment is fixed in **§5**.

⭐ Both clauses are exercises of **`BC-26`'s existing authority** at **L135**/**L385**. Neither creates a new
authority, a new context, a new aggregate, a new store or a new projection engine.

---

## 3. `ProfileViews` — the authoritative semantic definition

⭐ **This section is the metric.** Everything in it is a **`BC-26` semantic-layer** property. C3 renders these
values and defines none of them (`LPP-FR-038`, `LPP-XC-013`).

### 3.1 Authoritative definition

> **`ProfileViews`** is the count of **`tenancy.LibraryProfileViewed` facts** attributed to a single library,
> over a single `BC-26`-defined period, after the exclusions in §3.3 and §3.4 are applied.

It is **the number of times a library's public profile was rendered** — not the number of people who rendered
it. ⭐ That distinction is the whole content of §5: it is why the metric can be certified while
`UniqueViewers` cannot.

| Property | Value |
|---|---|
| **Name** | `ProfileViews` |
| **Owning context** | **`BC-26` Analytics Read Model** — sole definitional authority (**L135**, **L385**) |
| **Class** | `CertifiedMetric`, a member of `BC-26`'s `Projection` aggregate (**L385**) |
| **Unit** | A dimensionless non-negative integer count of events |
| **Grain** | One library (tenant), one period |
| **Sole input** | `tenancy.LibraryProfileViewed`, arriving over **`E-30`** (`ADR-0096`) |
| **Rebuildability** | **MUST** be fully rebuildable by replaying the event log. It is **not** a system of record (**L385**) |
| **Audience** | ⛔ **Owner/admin only, never public** — §4.4 |

### 3.2 Counting rule

- **One qualifying `tenancy.LibraryProfileViewed` fact increments `ProfileViews` by exactly one.**
- The metric counts **events**, not viewers, not sessions and not devices.
- Attribution is to the **library named as the subject** of the fact. ⛔ A fact **MUST NOT** be attributed to
  any other library, and **MUST NOT** be aggregated across libraries for an owner readout.
- A period's value **MUST** be derivable from the event log alone, with no external input and no stored
  counter treated as a source of truth.

### 3.3 Duplicate handling — ⭐ stated as a deliberate *non*-deduplication

> **`ProfileViews` performs NO viewer-level deduplication.** The same visitor rendering the same profile ten
> times contributes **ten**.

⭐ **This is a definition, not an omission, and it is forced by `ADR-0096` §4.2.** The event carries **no
viewer identity, no device identifier and no fingerprint** — by design, as the privacy control. A metric
cannot deduplicate by an identifier that was never transmitted. Certifying a deduplicated count would
therefore require either a fabricated definition or a payload change that reintroduces the identifier
`LPP-FR-039` forbids. **Both are refused.**

Two narrow, non-viewer-based exclusions **are** required, because neither needs an identity:

| Exclusion | Rule |
|---|---|
| **Transport duplicates** | Where §9.1's Event Delivery Contract redelivers the **same** fact (at-least-once semantics), the duplicate **MUST NOT** be counted. This is **event-identity** idempotency, not viewer deduplication |
| **Non-render requests** | A request that does not result in a successfully rendered public profile — a refusal, an error, a `LPP-FR-031` indistinguishable response, a prefetch that renders nothing — **MUST NOT** produce a countable fact |

⭐ **Consequence, stated so it is never mistaken for a defect:** `ProfileViews` is an **impression count**.
It is **not** a visitor count and **MUST NOT** be labelled, described or presented as one — see §4.3.

### 3.4 Bot and non-human handling

> **Non-human traffic MUST be excluded from `ProfileViews` wherever `BC-26` can identify it.**

| Rule | Statement |
|---|---|
| **B1** | Automated, crawler, indexer, scraper, uptime-monitor and synthetic-test traffic **MUST** be excluded to the extent `BC-26` can identify it without viewer identity |
| **B2** | ⛔ **`BC-26` is the sole authority** on what qualifies as non-human. C3 **MUST NOT** apply, override, supplement or second-guess the classification (`LPP-FR-038`) |
| **B3** | ⛔ **Bot classification MUST NOT be implemented by identifying, fingerprinting or profiling viewers.** It operates on request characteristics, never on viewer identity — otherwise the exclusion would defeat `ADR-0096` §4.2 |
| **B4** | ⚠ **The classification method is deliberately UNSPECIFIED.** No signal list, heuristic, threshold or vendor is fixed here — that is an implementation concern inside `BC-26`, and fixing it would exceed the granted authority. Recorded as an **open residue**, in the manner of `ADR-0085`'s `CID-6` |
| **B5** | **The library owner's own visits are counted** unless `BC-26` publishes a documented exclusion. ⭐ Stated explicitly because C3 `LPP-FR-038` names *"whether an owner's own visit counts"* as an open question and it must not stay open. It is answered **counted-by-default** — the honest answer given B3: distinguishing the owner's visit requires knowing who the viewer is, which the payload forbids. ⛔ Presenting an inflated number as *"visitors"* is prevented by §4.3's labelling rule, not by a definition that cannot be implemented |

### 3.5 Trend period

C3 `LPP-FR-037` requires a comparison (*"+18% this week"*) published by `BC-26` over `BC-26`-defined periods,
and forbids C3 from computing the delta or choosing the window.

| Rule | Statement |
|---|---|
| **T1** | The **certified trend period is a rolling 7-day window**, compared against the **immediately preceding, non-overlapping 7-day window**. This is the **only** certified comparison |
| **T2** | The **trend value is computed by `BC-26`** and published as a value. ⛔ C3 **MUST NOT** compute, derive, smooth, annualise, extrapolate or project it (`LPP-FR-037`) |
| **T3** | The period **MUST** be labelled explicitly wherever the trend is rendered. ⛔ **A trend without a stated period MUST NOT be rendered** (`LPP-FR-037`, restated here as a metric property so the obligation survives independently of C3) |
| **T4** | Where the prior window has **insufficient data** — a library newer than the comparison window, or a window suppressed under §3.6 — the trend **MUST be omitted**. ⛔ It **MUST NOT** be rendered as `0%`, `—`, *"no change"*, *"new"* or *"coming soon"*. The count may still render; only the comparison is withheld |
| **T5** | ⛔ **No other period is certified.** Daily, monthly, quarterly, all-time, year-over-year and custom ranges are **not** certified by this ADR. They belong to `PRD-009`'s analytics surface and require their own authorisation. ⭐ This is why `LPP-FR-042`'s **[View Analytics]** CTA hands off rather than expanding inline |

### 3.6 Privacy and suppression rules

⭐ **The primary privacy control is upstream**: `ADR-0096` §4.2 excludes viewer identity from the payload, so
`ProfileViews` is computed from facts that identify **no one**. The rules below are the **second** layer.

| Rule | Statement |
|---|---|
| **P1** | ⛔ **`ProfileViews` MUST NOT be accompanied by, joined to, or resolvable into any viewer list, identity, partial identifier, device identifier or individual view timestamp** (`LPP-FR-039`; `ID-3`; §14A.5 never-public) |
| **P2** | **Small-value suppression.** Where a value is small enough that, combined with information otherwise available to the owner, it could identify an individual viewer, `BC-26` **MUST** suppress it rather than publish it. **`BC-26` owns the threshold**; ⛔ C3 **MUST NOT** define, apply, infer or work around it (`LPP-FR-040`) |
| **P3** | A **suppressed** value **MUST** be rendered as suppressed or omitted. ⛔ It **MUST NOT** be rendered as zero, and ⛔ **MUST NOT** be inferable from response shape, size class, ordering or timing (`LPP-FR-031`) |
| **P4** | ⛔ **No social signal.** `ProfileViews` **MUST NOT** be broken down, filtered, segmented or annotated by any social relation — friend, follower, group member or peer — under any aggregation (`X-05`; `LPP-FR-041`) |
| **P5** | ⛔ **Never public.** §14A.5 places *Internal Analytics* on the **never-public** list and `LIB-14B.22` repeats it. `ProfileViews` **MUST NOT** appear in an anonymous response *in any form, including aggregated, derived, inferred, cached, embedded-metadata or error-message form* (`LPP-FR-030`) |
| **P6** | **Tenant-scoped readout.** The metric is `AR-3` **Tenant Operational Data**, **not** Platform Public Discovery Index. A read **MUST** carry tenant context and **MUST** be refused where it is absent or mismatched (`MP-GBR-08`, `SE-1`, `X-13`, **L490**, `LPP-FR-034`) |
| **P7** | ⚠ **No Privacy Owner review is asserted.** `PRD_OWNERSHIP_MODEL.md` **L509** records that *"no holder is appointed"*; `XPC-CONF-013` records the vacancy. ⛔ This ADR **does not** claim privacy sign-off, **does not** fill the role, and **does not** resolve `XPC-CONF-013`. The rules above are drawn from **already-binding** frozen and Rank 4 sources, which is why they can be stated without that role |

---

## 4. Rendering obligations that follow from the definition

⛔ **This section defines nothing new.** It records the consequences of §3 that a renderer must honour, so the
metric cannot be presented in a way its definition does not support.

| # | Obligation | Source |
|---|---|---|
| **4.1** | C3 **reads** the value. ⛔ It does not count, increment, store-as-source, cache-as-source, aggregate, sample or re-derive | `LPP-FR-035` |
| **4.2** | Where `BC-26` is unavailable or the value cannot be resolved, the summary **MUST** mark itself temporarily unavailable. ⛔ **MUST NOT** render zero, a stale value of unknown age, or an inferred value. ⛔ **MUST NOT** fail the public profile | `LPP-FR-044` |
| **4.3** | ⭐ **The label MUST match the definition.** `ProfileViews` **MUST** be presented as **views**. ⛔ It **MUST NOT** be labelled or described as visitors, people, unique visitors, users, viewers, reach or audience — §3.3 makes it an impression count, and §3.4 **B5** counts the owner's own visits | §3.3, §3.4 **B5** |
| **4.4** | Rendered **only** to a caller authorised under `LPP-FR-032`/`LPP-FR-033` (`PO-12`, delegated to `BC-18`). For every other caller the summary and its CTA are **absent** — not disabled-with-explanation, not present-and-refusing | `LPP-FR-031`, `LPP-FR-032`, `LPP-FR-033`, `LPP-FR-043` |
| **4.5** | Deeper analysis — other periods, breakdowns, segments, funnels, exports, date pickers — is **handed off** to `PRD-009`/`BC-26`, never rendered inline | `LPP-FR-042`, §3.5 **T5** |

---

## 5. ⛔ `UniqueViewers` — NOT certified, and the treatment is mandatory

### 5.1 The ruling

> ⛔ **`UniqueViewers` is NOT a `CertifiedMetric`. It has no authoritative definition. It MUST NOT be
> rendered.**

### 5.2 Why — and why this is coherence rather than an omission

The owner instructed it, and the architecture independently requires the same answer:

| # | Reason | Measured basis |
|---|---|---|
| 1 | ⭐ **It is not computable from the certified input.** `ADR-0096` §4.2 excludes **all** viewer identity, device identifiers and fingerprints from `tenancy.LibraryProfileViewed`. Uniqueness cannot be computed from facts that identify no one. **Certifying it would require certifying a value nothing can produce** | `ADR-0096` §4.2 |
| 2 | ⭐ **Making it computable would require breaking a privacy rule.** The only way to count distinct viewers is to carry something that distinguishes them — which is precisely what `LPP-FR-039`, `ID-3` and §14A.5's never-public list forbid | `LPP-FR-039`; `ID-3`; §14A.5 |
| 3 | **C3 already anticipated exactly this outcome.** `LPP-FR-036` is drafted as **⚠ CONDITIONAL**: *"**Unique Viewers MUST** be rendered **only where `BC-26` publishes it as a `CertifiedMetric`**… Where the metric is not published, the field **MUST** be omitted — **not** shown as zero, unknown or 'coming soon'."* ⭐ This ADR does not amend `LPP-FR-036`; it **supplies the fact** that resolves its condition to *omit* | `LPP-FR-036` |
| 4 | **The two-decision structure exists for this case.** `XPC-OD-007` was split into **A** (producer/edge) and **B** (metrics) precisely so that a lawful fact would not silently imply certification of every metric anyone might want from it | Form §4, §5 |

⭐ **The asymmetry is therefore the *consistent* outcome, not a compromise.** `ADR-0096` chose privacy at the
producer; this ADR declines the metric that choice makes uncomputable. Certifying both would have required
either a fabricated definition or a payload that re-identifies viewers.

### 5.3 Mandatory treatment — how it must be absent

| Rule | Statement |
|---|---|
| **U1** | ⛔ The field **MUST be OMITTED** from the rendered summary |
| **U2** | ⛔ **MUST NOT** be rendered as **zero** |
| **U3** | ⛔ **MUST NOT** be rendered as **unknown**, `—`, `n/a`, blank-with-label or any placeholder |
| **U4** | ⛔ **MUST NOT** be rendered as **"coming soon"**, "not yet available", or any forward-looking promise |
| **U5** | ⛔ **MUST NOT** be rendered as a disabled, greyed, blurred, locked, teaser or upsell element |
| **U6** | ⛔ **MUST NOT** be approximated, estimated, modelled or inferred from `ProfileViews` or any other signal — an estimate presented beside a certified value would be indistinguishable from one, and C3 is forbidden to compute uniqueness at all (`LPP-FR-036`) |
| **U7** | ⛔ C3 **MUST NOT** compute uniqueness, deduplicate by identifier, fingerprint a device or infer distinctness from any signal (`LPP-FR-036`, verbatim obligation preserved) |
| **U8** | ⚠ **It remains CONDITIONAL, not forbidden forever.** `LPP-FR-036`'s condition stands unamended: should `BC-26` in future publish `UniqueViewers` as a `CertifiedMetric` **under a definition that does not require viewer identity**, `LPP-FR-036` admits it with **no** C3 amendment. ⛔ This ADR does **not** authorise that future definition and does **not** predict one |

⭐ **`U5` and `U6` are the rules that matter commercially.** A blurred or teased *"Unique Viewers"* is the
most likely way this ruling would be violated in practice — it looks like a product decision rather than a
metric definition. It is forbidden here because it would render an uncertified metric's *existence* as a
fact, which is the same defect as rendering its value.

---

## 6. ⭐ Why nothing is edited, and why `PRD-009` is not created

### 6.1 Nothing needs to be edited

| Candidate edit | Why it is not made |
|---|---|
| Amend `BC-26`'s BC Map row (**L135**) | ⛔ **Unnecessary.** It **already** reads *"Owns the metric/semantic layer, read-model store, projections, reports, exports."* Defining a metric **exercises** that ownership; it does not extend it |
| Amend `BC-26`'s aggregate row (**L385**) | ⛔ **Unnecessary.** `CertifiedMetric` is **already** a member of `Projection`, and the invariant *"metric definitions single-sourced from the semantic layer"* is **already** the rule this ADR obeys. ⭐ Listing instances in a Rank 4 aggregate row would make every future metric an architecture change — the opposite of what **L385** intends |
| Add an edge | ⛔ **Unnecessary.** `E-30` is minted by `ADR-0096`; a metric derived from an arriving fact crosses no further boundary |
| Amend C3 `LPP-FR-036` | ⛔ **Refused.** Its condition is *already* correct and its **omit** branch is *already* mandatory. Editing it would replace a conditional requirement with a hard prohibition and destroy `U8` |

⭐ Hence this ADR follows `ADR-0094`: **declaratory**, deciding a question authoritatively while editing
nothing. `ADR-0060` is the earlier precedent for that shape.

### 6.2 `PRD-009` is **not** created, and remains `PLANNED`

The instrument said: *"Do not create `PRD-009` unless the repository requires an existing authorized
artifact."* **It does not.**

- `PRD_REGISTRY.md` **L246** registers `PRD-009 Analytics & Reports` → `BC-26`, V1, **`PLANNED`**. That
  registration is **byte-unchanged**.
- Authoring a full analytics PRD to define one metric would be **vastly larger** than the smallest compatible
  change, and would commit dashboards, reports and exports **no owner has authorized**.
- ⭐ **`PRD-009` is not obsolete.** It **remains the registered home** of the analytics *product surface* —
  the destination of `LPP-FR-042`'s CTA, and the place where §3.5 **T5**'s uncertified periods, breakdowns
  and exports belong. This ADR defines **one metric**, not that surface.
- ⛔ `PRD_REGISTRY.md` is **append-only** and is **not** touched. No PRD is created, renamed, re-scoped or
  re-statused.

---

## 7. What this closes, and what it does not

**Closes `XPC-OD-007B`.** `ProfileViews` has an authoritative definition; `UniqueViewers` has a mandatory
treatment. C3's `LPP-FR-035`, `LPP-FR-036`, `LPP-FR-037`, `LPP-FR-038`, `LPP-FR-040` and `LPP-FR-044` now
rest on decided semantics.

**With `ADR-0096`, `XPC-OD-007` is closed in full** — producer, edge and metric.

⛔ **Does NOT close:**

- `XPC-OD-004`, `XPC-OD-005`, `XPC-OD-006` — **all three remain OPEN**, unmentioned by the authority
  instrument and outside this ADR's authority.
- `XPC-CONF-013` — the **Privacy Owner VACANT** conflict. ⭐ Explicitly **not** resolved (§3.6 **P7**).
- ⛔ **No lifecycle stage.** `PRD-021C` and all parts remain **DRAFT at Stage 2**, **NOT FROZEN**, **NOT
  APPROVED**, **NOT BASELINED**. Stage 3 **not** entered; no alignment record; no `IMPL-*`.

---

## 8. Alternatives considered

| Option | Verdict |
|---|---|
| **A** — certify **both** `ProfileViews` and `UniqueViewers` | ⛔ **Rejected by the owner, and independently impossible.** `UniqueViewers` is not computable from the certified input without breaking `ADR-0096` §4.2 (§5.2) |
| **B** — certify **`ProfileViews` only** | ✅ **SELECTED.** Certifies exactly what the input supports; leaves `LPP-FR-036`'s conditional intact |
| **C** — certify **neither** | ⛔ Rejected by the owner. Would leave C3 §9A blocked and the 👁️ Profile Views requirement undeliverable after an edge had been lawfully minted to carry it |
| **D** — author `PRD-009` and define the metrics there | ⛔ Rejected — §6.2. Far larger than the smallest compatible change; would commit an unauthorized product surface |
| **E** — let C3 define the semantics | ⛔ Rejected. `LPP-XC-013` and `LPP-FR-038` forbid it, and C3's own commentary explains why it would create a parallel analytics system |
| **F** — render `UniqueViewers` as zero / "coming soon" / blurred | ⛔ **Explicitly forbidden** by the instrument *and* by `LPP-FR-036` as already drafted — §5.3 `U2`–`U6` |

---

## 9. Consequences

**Positive**

- ⭐ The **first** `CertifiedMetric` instance in the repository exists, exercising an authority **L385**
  granted and nothing had used.
- C3 §9A's 👁️ Profile Views and its trend become deliverable; the readout stays render-only.
- The privacy posture is coherent **end to end**: no viewer identity at the producer (`ADR-0096` §4.2), no
  identity-dependent metric here, and no placeholder that hints at one (§5.3).
- ⭐ `ProfileViews` cannot be **mislabelled** as visitors — §4.3 closes the gap that `B5` would otherwise open.

**Negative — accepted**

- The owner sees **views, not visitors**, and one enthusiastic visitor can inflate the number. Accepted, and
  **disclosed by the label** rather than hidden behind a definition that cannot be implemented.
- Only **one** comparison period is certified (**T1**). Everything else requires the CTA hand-off. Accepted:
  certifying periods no one has specified would be inventing a product.
- ⚠ The bot-classification method is an **open residue** (**B4**), in the manner of `ADR-0085`'s `CID-6`.
- ⚠ The suppression **threshold** is `BC-26`'s and is not numerically fixed here (**P2**) — deliberately, as
  a semantic-layer implementation concern.

**Not a consequence**

- ⛔ No bounded context, aggregate, invariant, edge or event is created, altered or removed by this ADR.
- ⛔ `PRD-009` is not created; `PRD_REGISTRY.md` is byte-unchanged.
- ⛔ No second analytics system, semantic layer, metric store or read model.
- ⛔ `UniqueViewers` is not forbidden forever — **U8**.
- ⛔ No metric other than `ProfileViews` is certified by this ADR.

---

## 10. Compliance

- ⛔ Does **not** certify `UniqueViewers`, and **does not** permit it to be rendered as zero, unknown,
  placeholder, "coming soon", disabled, blurred, teased or estimated.
- ⛔ Does **not** create `PRD-009`; it remains **`PLANNED`** at `PRD_REGISTRY.md` **L246**.
- ⛔ Does **not** modify `PRD_REGISTRY.md` (append-only), the BC Map, any FROZEN artefact, or `LPP-FR-036`.
- ⛔ Does **not** create a second analytics authority — `BC-26` remains sole owner of the metric/semantic
  layer, read-model store, projections, reports and exports (**L135**).
- ⛔ Does **not** let C3 compute, define, version, deduplicate, estimate or re-derive any metric.
- ⛔ Does **not** consume `ADR-0088`, `ADR-0089` or `ADR-0090` — **reserved and unwritten** for `PRD-021B`
  per `ADR-0091` **L315**. Verified absent by exact filename before this number was taken.
- ⛔ Does **not** rewrite any historical ADR.
- ⛔ Does **not** resolve `XPC-OD-004`, `XPC-OD-005`, `XPC-OD-006` or `XPC-CONF-013`.
- ⛔ Does **not** assert Privacy Owner review, Security review or ARB quorum — §3.6 **P7**.
- ⛔ Does **not** expose individual viewer identities, view lists or individual view timestamps.
- ⛔ Does **not** publish any analytic on a public surface — **P5**.
- ⛔ Does **not** enter Stage 3, create an Alignment Record, claim alignment `PASS`, mint an `IMPL-*`, write
  application code, freeze, baseline, rank or approve `PRD-021C`.
