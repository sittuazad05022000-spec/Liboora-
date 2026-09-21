# ADR-0169 — V1 public seat availability: the denominator is the **configured seat count**, and **zero configured capacity renders `Full`**

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — **2026-09-19**, recording a Product Owner decision taken directly and quoted **verbatim** at **§7.1**. ⚠️⚠️ **NO INDEPENDENT REVIEW CLAIMED** |
| **Rank** | 2 — Architecture Decision Record |
| **Date prepared** | 2026-09-19 |
| **Bounded context** | `BC-04` Seating *(computes the state; owns seat inventory)* · Library §14B Public Preview *(the contract served)* |
| **Supersedes** | ⛔ **NOTHING** |
| **Superseded by** | — |
| ⭐⭐ **Deciding authority** | ⭐⭐ **Product Owner** — `PRD_OWNERSHIP_MODEL` §2.2; ⭐ the office **`ADR-0168`** §5 and §9 expressly routed both gaps to |
| **Contributing offices** | ⛔⛔ **NONE** claimed or exercised |
| **Decides** | ⭐ **`GAP-SEATAVAIL-CAPACITY`** *(the denominator)* · ⭐ **`GAP-SEATAVAIL-ZEROCAP`** *(the `C = 0` case)*. ⛔ **Nothing else** |
| **Expressly does NOT decide** | ⛔ The 80% / 100% thresholds *(unchanged — `ADR-0168`)* · ⛔ the derivation input class *(unchanged — allocation only)* · ⛔ `E-35` *(`ADR-0167`)* · ⛔ the event **name** · ⛔ the BC Map amendment · ⛔ any UI, copy or layout · ⛔ `SEAT-CFG-017` · ⛔ `SEAT-GAP-005` / `SEAT-GAP-011` / `SEAT-GAP-014` · ⛔ `LIB-24.2`'s privacy review · ⛔ Public Live Occupancy *(stays **V2**)* · ⛔ any `PERM-*`, role, office or scope |
| **Amends** | ⛔⛔ **NOTHING.** ⭐ It **completes** the formula `ADR-0168` `D-1` left with an unresolved denominator and an undefined edge case |
| **Origin** | ⭐ **`ADR-0168`** §5.1 and §5.2 — the two **blocking** Product Owner acts |

> ⭐⭐ **Identifier check, immediately before drafting.** `ADR-0168` highest on disk;
> `ADR-0169` measured **0** files and **0** references; `ADR-0150`…`ADR-0168`
> gap-tested **contiguous**. ⛔ No number reused *(Process rule 2)*.

---

## 1. ⭐⭐ The decisions

### `D-1` — ⭐ `GAP-SEATAVAIL-CAPACITY`: the denominator is the **configured seat count**

⭐⭐ **`C` = the seat count configured in `BC-04`.** ⛔ **NOT** the `Floor`'s declared
capacity *(`LIB-10.4`)*.

⭐ The public availability ratio is therefore:

> **`A / C`** where **`A`** = seats with an **active allocation**, **`C`** = the
> **configured seat count in `BC-04`**

### `D-2` — ⭐⭐ The discrepancy is PRESERVED, ⛔ not reconciled

⭐ Where declared capacity and configured seat count differ, the difference
**MUST** continue to be surfaced **internally**, exactly as **`SEAT-FR-018`** and
**`LIB-10.5`** require.

⛔⛔ **Choosing `BC-04`'s figure as the public denominator is NOT a reconciliation
of the two values.** ⭐ Both figures remain distinct, both remain surfaced
internally, and ⛔ **neither is silently corrected.** ⭐ `SEAT-AC-010`'s
*"50 declared / 60 configured → both shown as distinct labelled values"* stands
**unchanged**.

⛔ **And the discrepancy itself is NOT published** — ⭐ only the state label reaches
the public surface *(`ADR-0168` `D-3`)*.

### `D-3` — ⭐ `GAP-SEATAVAIL-ZEROCAP`: `C = 0` renders **`Full`**

⭐⭐ **Where the configured seat count is `0`, the public availability state is
`Full`.**

⭐ This is a **defined case, not a computed one** — ⛔ `A / C` is undefined at
`C = 0`, so the state is assigned **by rule**, ⛔ not by arithmetic. ⭐ §3.3 explains
why this matters for implementation.

### `D-4` — ⛔ Everything else is unchanged

| Item | State |
|---|---|
| Thresholds `<80` / `80–<100` / `=100` | ⭐ **UNCHANGED** *(`ADR-0168` `D-1`)* |
| Derivation input | ⭐ **Allocation only** — ⛔ **never** attendance or presence |
| Free-seat counts | ⛔ **PRIVATE** |
| `SEAT-CFG-017` / the 90% | ⛔⛔ **V2, HELD** — untouched |

---

## 2. ⭐ The completed V1 rule

⭐⭐ **For the first time the public availability projection is fully specified.**

| # | Condition | State |
|---|---|---|
| 1 | ⭐ `C = 0` | ⭐⭐ **`Full`** *(`D-3` — by rule)* |
| 2 | `C > 0` and `A / C` **< 80%** | **`Available`** |
| 3 | `C > 0` and **80% ≤** `A / C` **< 100%** | **`Limited Availability`** |
| 4 | `C > 0` and `A / C` **= 100%** | **`Full`** |

⭐ Where **`A`** = seats with an active allocation, **`C`** = the configured seat
count in `BC-04`.

⭐⭐ **Total: exhaustive and mutually exclusive over every reachable input**,
including `C = 0`. ⛔ There is now **no** input for which the state is undefined,
and ⛔ none for which two states apply.

⚠️ **`A / C > 100%` is not reachable** — ⭐ BC Map **L373** guarantees *"**One active
allocation per seat per time window**"* by pessimistic lock / DB unique constraint,
so `A ≤ C` structurally. ⭐⭐ **`D-1` is what makes that guarantee hold**, and §3.2
shows this was decisive.

---

## 3. ⭐ Why these decisions are sound on the evidence

### 3.1 ⭐⭐ `D-1` matches a Rank-3 rule that already answers the same question

⭐ **`LIB-10.5`** *(Library PRD, Rank 3, Approved — authoritative)*:

> *"Where declared Floor Capacity and the seat count configured in `BC-04`
> disagree, **`BC-04` MUST be treated as authoritative for operations**, and the
> discrepancy **MUST** be surfaced to the Owner rather than silently reconciled."*

⭐ And **`LIB-10.4`**:

> *"Floor Capacity **MUST** be a **declared planning figure**… It **MUST NOT** be
> treated as **seat inventory**, which is **owned by `BC-04` Seating**."*

⭐ With the authors' own rationale:

> *"'Floor Capacity' is genuinely **ambiguous**. It can mean 'this floor was
> designed for 40 people' or 'there are 40 seats on this floor'. The first is a
> library property; the second is **seat inventory belonging to `BC-04`**… **The
> planning figure stays here; operations trust `BC-04`.**"*

⭐⭐ **The Product Owner's choice is the one the existing hierarchy already
mandates.** ⛔ Choosing the declared figure would have made a **planning number**
govern a **live operational surface**, which `LIB-10.4` forbids in terms.

⚠️ ⭐ **One honest qualification.** `LIB-10.5` says *"authoritative **for
operations**"*, and a public read projection is arguably a **read**, not an
operation. ⭐⭐ So `LIB-10.5` is **strong corroboration, ⛔ not a self-executing
answer** — which is precisely why the gap was routed to the Product Owner rather
than closed by inference in `ADR-0168`. ⭐ **The decision was needed; it is now
made, and it aligns with the rule.**

### 3.2 ⭐⭐ `D-1` is the only choice under which the formula cannot break

| Denominator | `A ≤ C` guaranteed? | Consequence |
|---|---|---|
| ⭐⭐ **Configured seat count** | ⭐ **YES** — BC Map **L373** invariant | ⭐ Ratio always in `[0%, 100%]`; ⭐ every value maps to exactly one band |
| ⛔ Declared capacity | ⛔⛔ **NO** | ⛔ `SEAT-AC-010`'s *50 declared / 60 configured* with 55 allocated ⇒ **`A/C = 110%`** — ⭐ a value `ADR-0168` `D-1` **does not define** |

⭐⭐ **`D-1` therefore closes a latent defect as well as the gap**: it removes the
only route to an out-of-range ratio.

### 3.3 ⭐ `D-3` is defensible, and its edge case is worth stating plainly

⭐ At `C = 0` a library has **no seats to offer**. ⭐⭐ `Full` is the state that
correctly answers the public's only question — *"do they have room for me?"* —
with **"no."**

| Candidate | ⭐ / ⛔ |
|---|---|
| ⭐⭐ **`Full`** *(chosen)* | ⭐ Truthful: no seat is obtainable. ⭐ Fail-safe: ⛔ it never over-promises |
| ⛔ `Available` | ⛔⛔ **False** — invites a wasted journey |
| ⛔ Omit the field | ⭐ Defensible *(`LIB-14B.11` makes seat information publishable, ⛔ not mandatory; §14A.5 says *"Seat Capacity (**Optional**)"*)*, ⛔ but leaves the seeker with no answer |
| ⛔ A fourth state | ⛔⛔ **Would breach `ADR-0168`'s closed three-value enumeration** |

⭐⭐ **The rule is deliberately NOT arithmetic.** ⛔ An implementation that computed
`A / C` first would divide by zero. ⭐ `D-3` must be evaluated as a **guard clause
before the ratio** — ⭐ the ordering shown at §2 row 1.

⚠️ ⭐ **One consequence, disclosed rather than hidden.** A library that has published
a profile but not yet configured a seat layout will read **`Full`**, which may look
odd to that library's Owner. ⭐⭐ **That is the correct trade** — ⛔ the alternative
tells a seeker seats are available when none exist. ⭐ If it later proves
undesirable, the remedy is the **omit-the-field** option, ⛔ which remains open to
the Product Owner and is **not** foreclosed here.

### 3.4 ⭐ No frozen rule is displaced

| Rule | Status after this ADR |
|---|---|
| `SEAT-FR-018` *(FROZEN)* | ⭐ **Fully preserved** — `D-2` |
| `SEAT-AC-010` *(FROZEN)* | ⭐ **Unchanged** — both figures still shown distinctly |
| `LIB-10.4` / `LIB-10.5` | ⭐ **Followed, not amended** |
| `LIB-7.3` *"aggregate count"* | ⭐ Unchanged — ⛔ and no count is published anyway |
| `LIB-14B.14` | ⭐ **Unchanged** — ⛔ allocation only, no attendance |
| `SEAT-FR-245` | ⭐ **Unchanged** — allocation rate, ⛔ not occupancy rate |

---

## 4. ⛔ Alternatives and inferences REFUSED

| # | Move | ⛔ Refused because |
|---|---|---|
| 1 | ⭐ Reconcile declared and configured capacity, now that one is chosen | ⛔⛔ **`SEAT-FR-018`** *(FROZEN)* and **`LIB-10.5`** — *"**MUST NOT** silently reconcile"*. ⭐ `D-2` preserves both |
| 2 | ⭐ Publish the discrepancy, since it is now surfaced internally | ⛔ `ADR-0168` `D-3`; `LIB-14B.12` — ⭐ only the **label** is public |
| 3 | ⭐ Treat `C = 0` as `Available` because zero allocations is 0% | ⛔⛔ **Arithmetically tempting and substantively false** — ⭐ `0/0` is undefined, ⛔ not `0%`, and no seat is obtainable |
| 4 | ⭐ Add a fourth state for `C = 0` | ⛔ Breaches `ADR-0168`'s **closed** three-value enumeration; ⛔ ⭐ `LIB-14B.12` names three |
| 5 | ⭐ Extend `D-1` to `SEAT-GAP-011` *(the Member Directory's seat column)* | ⛔⛔ **Out of scope** — ⭐ the instruction limits these decisions *"only to the V1 … public availability projection"*; ⭐ `SEAT-GAP-011` is a **`BC-01` owner** question and stays **OPEN** |
| 6 | ⭐ Amend `PRD-007` or the Library PRD to record the choice | ⛔⛔ **Expressly prohibited** — *"do not modify frozen/approved specifications"*; ⭐ `PRD-007` is **FROZEN** |
| 7 | ⭐ Record this inside `ADR-0168` | ⛔⛔ **Process rule 2** — *"**Never edit an Accepted ADR's decision text**"*. ⭐ `ADR-0168` is `Accepted` |
| 8 | ⭐ Revisit the 80% now that the denominator is fixed | ⛔ **Expressly excluded** — *"Keep the existing 80% / 100% thresholds unchanged"* |

---

## 5. ⭐ Authority

⭐ **Product Owner** — `PRD_OWNERSHIP_MODEL` §2.2 *("business intent: scope,
priority, acceptance")*. ⭐⭐ **`ADR-0168` §5.1 and §5.2 routed both gaps to this
office by name**, and §9 marked both **BLOCKING**.

⭐⭐ **The decision is genuinely a product one in both limbs.** ⭐ `D-1` selects which
of two legitimate, co-existing business figures expresses the public promise —
⛔ not a data-lineage question *(`ADR-0167` settled lineage)*. ⭐ `D-3` chooses what
to tell a seeker when there is nothing to offer — ⛔ a product-intent question with
no architectural content.

⛔ **This office may NOT:** create roles or permissions *(⛔ instruction;
`AUTH-7.22` closed at zero)* · amend frozen/approved specs *(⛔ instruction)* ·
alter edges or boundaries *(**Architecture Owner**)* · decide document status
*(**Governance Owner**)*.

---

## 6. ⭐ What remains before implementation

| # | Act | Office | Status |
|---|---|---|---|
| ~~1~~ | ~~Thresholds~~ | ~~Product Owner~~ | ⭐ **DONE** — `ADR-0168` |
| ~~1a~~ | ~~`GAP-SEATAVAIL-CAPACITY`~~ | ~~Product Owner~~ | ⭐⭐ **DONE — this ADR** |
| ~~1b~~ | ~~`GAP-SEATAVAIL-ZEROCAP`~~ | ~~Product Owner~~ | ⭐⭐ **DONE — this ADR** |
| **2** | Mint the `E-35` event **name** in `BC-04`'s closed register *(`SEAT-FR-206`/`207`)* | **Architecture Owner** | ⛔⛔ **BLOCKING** |
| **3** | Execute the BC Map append → **v1.19** | **Architecture Owner** | ⛔⛔ **BLOCKING** |
| **4** | Register `ADR-0167`, `ADR-0168`, `ADR-0169` in `ADR-INDEX` | **Governance Owner** | ⛔ Outstanding |
| **5** | Design the public surface | **UX Architecture Owner** | ⛔ Outstanding |
| **6** | Implement | Technical | ⛔ Outstanding |

⭐⭐ **The product specification is now COMPLETE.** ⛔ Every remaining blocker is an
**architecture or governance** act — ⛔ **none is a product question.**

---

## 7. ⭐⭐ Authority record

### 7.1 ⭐⭐ The decision — VERBATIM

> ⭐⭐ **VERBATIM — human principal of this engagement, as Product Owner, 2026-09-19:**
>
> ```
> "As Product Owner, I resolve the two remaining V1 public seat-availability gaps:
>
> 1. `GAP-SEATAVAIL-CAPACITY`: Use the configured seat count as the denominator
> for the public availability ratio. If declared capacity differs, preserve and
> surface that discrepancy internally as required by `SEAT-FR-018`; do not
> silently reconcile the two values.
>
> 2. `GAP-SEATAVAIL-ZEROCAP`: If configured capacity is `0`, the public
> availability state is `Full`.
>
> These decisions apply only to the V1 `Available / Limited Availability / Full`
> public availability projection. Keep the existing 80% / 100% thresholds
> unchanged, use allocation only (never attendance), and do not modify
> frozen/approved specifications, permissions, roles, or `SEAT-CFG-017`. Record
> the decisions in a new ADR."
> ```

### 7.2 ⭐ Validity

| # | Element | Supplied? | Words relied on |
|---|---|---|---|
| 1 | First-person, office named | ⭐ **YES** | *"**As Product Owner, I resolve**"* |
| 2 | Both gaps identified by ID | ⭐ **YES** | *"`GAP-SEATAVAIL-CAPACITY`"* · *"`GAP-SEATAVAIL-ZEROCAP`"* |
| 3 | Each decision stated | ⭐ **YES** | *"configured seat count as the denominator"* · *"the public availability state is `Full`"* |
| 4 | ⭐⭐ Preservation limb | ⭐ **YES** | *"**preserve and surface that discrepancy internally** … **do not silently reconcile**"* |
| 5 | Scope limit | ⭐ **YES** | *"**only** to the V1 … public availability projection"* |
| 6 | Non-regression limbs | ⭐ **YES** | *"thresholds unchanged"* · *"allocation only (never attendance)"* |
| 7 | Express prohibitions | ⭐ **YES** | *"do not modify frozen/approved specifications, permissions, roles, or **`SEAT-CFG-017`**"* |
| 8 | Recording instruction | ⭐ **YES** | *"**Record the decisions in a new ADR**"* |

⭐⭐ **8 / 8.** ⭐ A **direct exercise** of the office — ⛔ not a conferral onto this
engagement, the same form as `ADR-0168` §8.3(a). ⛔ **No personal name is recorded**
*(`PRD_OWNERSHIP_MODEL` §7 rule 4)*.

⭐ **Element 8 says *"a new ADR"* expressly** — ⭐⭐ which independently confirms the
§4 row 7 refusal to edit `Accepted` `ADR-0168`.

### 7.3 ⛔ Not reused

⛔ `ADR-0167`'s **Architecture Owner** conferral *(reverted; different office)* ·
⛔ `ADR-0162` §2, `ADR-0164` §10.2, `ADR-0165` §9.1, `ADR-0166` §9.1 — ⭐ all
**Authorization Owner**, all spent. ⭐ `ADR-0168` was a **direct Product Owner
exercise**, ⛔ not a reusable instrument.

### 7.4 ⭐ Acceptance

⭐ As with `ADR-0168`, the decision **pre-exists this ADR**; ⭐⭐ the status is
`Accepted` **as a record of a Product Owner decision**, ⛔ **not** as an independent
governance ratification of it.

---

## 8. ⭐ Sources

| # | Source | Locus | Relied on for |
|---|---|---|---|
| 1 | ⭐⭐ `ADR-0168` | `D-1`, `D-3`, §5.1, §5.2, §9 | ⭐ **The thresholds, and the routing of both gaps** |
| 2 | `ADR-0167` | `D-2`, `D-3` | The edge and the payload boundary |
| 3 | ⭐⭐ `Library_PRD_v1.md` | **`LIB-10.4`**, **`LIB-10.5`** + rationale, `LIB-7.3` | ⭐ ***"operations trust `BC-04`"*** — the corroboration for `D-1` |
| 4 | ⭐ `PRD-SEAT-MANAGEMENT.md` **FROZEN** | **`SEAT-FR-018`**, **`SEAT-AC-010`**, `SEAT-FR-245`, `SEAT-GAP-011` | ⭐ **The discrepancy rule preserved by `D-2`** |
| 5 | `14B-Public-Library-Preview.md` | `LIB-14B.11`, `LIB-14B.12`, `LIB-14B.14`, §14A.5 *"Optional"* | The contract; the omit-the-field option |
| 6 | ⭐ `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **L373** | ⭐ **The `A ≤ C` invariant that `D-1` preserves** |
| 7 | `PRD_OWNERSHIP_MODEL` | §2.2, §7 rule 4 | The Product Owner's remit; ⛔ no personal name |
| 8 | `ADR-INDEX` | Process rule 2 | ⛔ Never edit an Accepted ADR |

---

## 9. ⭐ Status after acceptance

| Item | State |
|---|---|
| **This ADR** | ⭐⭐ **Accepted** — 2026-09-19 |
| ⭐ **`GAP-SEATAVAIL-CAPACITY`** | ⭐⭐ **CLOSED** — denominator = configured seat count |
| ⭐ **`GAP-SEATAVAIL-ZEROCAP`** | ⭐⭐ **CLOSED** — `C = 0` ⇒ `Full` |
| ⭐⭐ **The V1 availability rule** | ⭐⭐ **COMPLETE** — §2; ⛔ no undefined input remains |
| **Thresholds / derivation / privacy** | ⭐ **UNCHANGED** |
| **`SEAT-FR-018` discrepancy duty** | ⭐ **PRESERVED** — internal, ⛔ not published |
| **`E-35`** | ⭐ Declared; ⛔ BC Map **not yet amended** · ⛔ event name **not minted** |
| **`SEAT-CFG-017` / 90%** | ⛔⛔ **V2, HELD** — untouched; `SEAT-GAP-005` **OPEN** |
| **`SEAT-GAP-011` / `SEAT-GAP-014`** | ⛔ **OPEN** — not engaged |
| **Public Live Occupancy** | ⛔ **V2** — unchanged |
| **`PERM-*`** | ⛔ **0** — `AUTH-7.22` closed at zero |
| **Coverage / holds** | ⭐ **95 / 104** · ⛔ **9** — unchanged |
| **`ADR-INDEX`** | ⛔ **Not modified** — a Governance Owner act |

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| ⭐⭐ **1.0** | 2026-09-19 | ⭐⭐ **Created and `Accepted`. Both remaining V1 public seat-availability gaps are CLOSED by the Product Owner: `GAP-SEATAVAIL-CAPACITY` — the denominator is the CONFIGURED SEAT COUNT in `BC-04`, ⛔ not the declared Floor Capacity; `GAP-SEATAVAIL-ZEROCAP` — where configured capacity is `0`, the public state is `Full`.** ⭐⭐ **THE V1 AVAILABILITY RULE IS NOW COMPLETE** *(§2)* — four ordered cases, ⭐ **exhaustive and mutually exclusive over every reachable input**, with ⛔ **no undefined input remaining**. ⭐⭐ **`D-1` MATCHES A RANK-3 RULE THAT ALREADY ANSWERS THE SAME QUESTION** *(§3.1)* — **`LIB-10.5`**: *"Where declared Floor Capacity and the seat count configured in `BC-04` disagree, **`BC-04` MUST be treated as authoritative for operations**"*, and **`LIB-10.4`**: Floor Capacity is *"a **declared planning figure**… **MUST NOT** be treated as **seat inventory**, which is **owned by `BC-04`**"*, with the authors' own rationale — ⭐⭐ ***"The planning figure stays here; operations trust `BC-04`."*** ⚠️ **One honest qualification recorded** — `LIB-10.5` says authoritative *"**for operations**"* and a public read is arguably a **read**, so it is ⭐ **strong corroboration, ⛔ not a self-executing answer**; ⭐⭐ which is exactly why `ADR-0168` routed the gap to the Product Owner rather than closing it by inference. ⭐⭐ **`D-1` ALSO CLOSES A LATENT DEFECT** *(§3.2)* — it is **the only denominator under which `A ≤ C` is structurally guaranteed** *(BC Map **L373**, *"One active allocation per seat per time window"*)*; ⛔ the declared figure permits `SEAT-AC-010`'s *50 declared / 60 configured* with 55 allocated ⇒ **`A/C = 110%`**, ⭐ a value `ADR-0168` `D-1` **does not define**. ⭐⭐ **THE DISCREPANCY DUTY IS PRESERVED, NOT DISCHARGED** *(`D-2`)* — ⛔ choosing a public denominator is **NOT** a reconciliation: FROZEN **`SEAT-FR-018`** and **`LIB-10.5`** continue to require the difference to be surfaced internally, ⭐ `SEAT-AC-010`'s *"both shown as distinct labelled values"* stands unchanged, and ⛔ **the discrepancy is not published** — only the label is. ⭐ **`D-3` IS A GUARD CLAUSE, ⛔ NOT ARITHMETIC** *(§3.3)* — `0/0` is **undefined, ⛔ not 0%**, so an implementation must test `C = 0` **before** computing the ratio; ⭐ `Full` is truthful *(no seat is obtainable)* and **fail-safe** *(⛔ it never over-promises)*, against ⛔ `Available` *(false)*, ⛔ omitting the field *(defensible — ⭐ §14A.5 says *"Seat Capacity (**Optional**)"* — ⛔ but it leaves the seeker no answer)* and ⛔ a fourth state *(would breach the **closed** three-value enumeration)*. ⚠️ **One consequence DISCLOSED rather than hidden** — ⭐ a library that publishes a profile before configuring a layout will read **`Full`**, which may look odd to its Owner; ⭐⭐ **that is the correct trade**, and the **omit-the-field** remedy ⛔ remains open and is **not foreclosed**. ⛔ **EIGHT MOVES REFUSED** *(§4)*, incl. ⛔ reconciling the two capacity figures now that one is chosen *(**FROZEN `SEAT-FR-018`**)*, ⛔ publishing the discrepancy, ⛔ treating `C = 0` as `Available` *(**arithmetically tempting and substantively false**)*, ⛔ extending `D-1` to **`SEAT-GAP-011`** *(the Member Directory column — ⭐ a **`BC-01` owner** question, **OPEN**, and the instruction limits scope to the public projection)*, ⛔ amending any frozen spec, and ⛔⛔ **recording this inside `ADR-0168`** — *"**Never edit an Accepted ADR's decision text**"*, ⭐ and the instruction itself said *"**a new ADR**"*. ⭐⭐ **THE PRODUCT SPECIFICATION IS NOW COMPLETE** *(§6)* — ⛔ **every remaining blocker is an ARCHITECTURE or GOVERNANCE act**: minting the `E-35` event name inside `BC-04`'s **closed** register *(`SEAT-FR-206`)*, the BC Map **v1.19** append, and `ADR-INDEX` registration of `ADR-0167`/`0168`/`0169`. ⛔ Supersedes **NOTHING** · ⛔ **0** frozen/approved specs modified *(`PRD-007` `03a8ba0a`, 14B, Library PRD, BC Map all byte-unchanged)* · ⛔ **0** `PERM-*` *(`AUTH-7.22` closed at zero)* · ⛔ **0** roles, offices or scopes · ⛔ **0** edges, contexts, aggregates or events · ⛔ **0** thresholds changed · ⛔ **0** counts published · ⛔ **0** UI or runtime code · ⛔ `SEAT-CFG-017`, `SEAT-GAP-005`, `SEAT-GAP-011`, `SEAT-GAP-014` and `LIB-24.2` untouched · ⛔ coverage **95 / 104** and **9** holds unchanged · ⛔ `ADR-INDEX` **not modified** · ⛔ **no commit, no push**. |
