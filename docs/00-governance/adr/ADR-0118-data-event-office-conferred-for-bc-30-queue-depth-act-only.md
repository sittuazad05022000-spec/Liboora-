# ADR-0118 — The **DATA / EVENT** office is constituted and conferred **for one act only**: to decide the `BC-30` Offline Sync queue-depth / backpressure bound

| Field | Value |
|---|---|
| **ADR** | `ADR-0118` |
| **Status** | **Accepted** — 2026-09-08 |
| **Date** | 2026-09-08 |
| **Deciders** | ⭐⭐ **The human principal of this engagement**, by **direct, explicit conferral**, constituting and authorizing the **`DATA / EVENT`** office **for the `BC-30` Offline Sync queue-depth / backpressure act only** — on the `ADR-0077` / `ADR-0080` / `ADR-0102` precedent for constituting an office that **Rank 1 already names but this repository defines nowhere**. ⛔ **No ARB quorum, attendee list, sign-off date or Security review is asserted. No holder is appointed and no personal name is recorded** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4) |
| **Subject** | Constitution and one-act conferral of the `DATA / EVENT` office |
| **Supersedes** | — |
| **Amends** | `docs/00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md` → **v1.6**. ⚠ **EXECUTED BY APPEND, NOT BY INSERTION — see §5.** The office is constituted in a new **§15**; every pre-existing line is **byte-identical** |
| **Amended by** | — |
| **Baseline** | ⛔ **No baseline re-issue.** `BASELINE-2026-09-03-A` stands — `PRD_OWNERSHIP_MODEL.md` is **Unranked** by its own `Precedence` row, so `DOCUMENTATION_BASELINE.md` §7 rule 4's Rank 1–3 limb is unmet |
| **Closes** | ⭐ **The office-existence limb of Item 7b only** — the `DATA / EVENT` office is now **constituted** and **authorized for one act**. This discharges required act **2** of `IMPLEMENTATION_BLOCKER_REGISTER.md` §13.5 |
| **Does NOT close** | ⛔⛔ **Item 7b itself.** The queue-depth / backpressure bound is **NOT decided in this ADR** — see §4. ⛔⛔ **Nor is the act yet EXERCISABLE** — it is expressly sequenced *after* the Item-3 durability model becomes authoritative, and it has not; see §4.2. ⛔ Items 3, 9b, 5, 7a, 8b-residual. ⛔ No implementation authority |
| **Related** | `MASTER_PRD.md` **L498** (`MP-NFR-04`, Rank 1 — owner `DATA / EVENT`) · `PRD_OWNERSHIP_MODEL.md` **§13**, **§7 rule 4**, **§3 rule 1**, **§2.3** · `ADR-0102` (the office-constituting precedent) · `ADR-0117` (the companion act, `EVENT platform` / Item 3) · `ADR-0033` §7.1 · `ADR-0115`, `ADR-0116` |
| **Implementation authorised** | ⛔ **No** |

> ⚠⚠ **READ THIS FIRST.** This ADR **constitutes an office**. It does **NOT** decide any queue-depth
> value or backpressure policy, and it authorises **no** implementation. ⚠ Its one act is **sequenced
> behind Item 3** and is therefore **not yet exercisable**.

---

## 1. Context

### 1.1 The blocker, as it stood

`IMPLEMENTATION_BLOCKER_REGISTER.md` §13.2 measured that **Item 7b — Queue Depth** was blocked for two
independent reasons, and that only one of them was the Item-3 dependency:

- The **obligation** exists at **Rank 1**. `MASTER_PRD.md` **L498**, `MP-NFR-04`:
  *"Scalability | CQRS read models, cache tier, queues, partitioning, **backpressure**. The **aggregate
  instance** is the atomic unit of scale. | **DATA / EVENT**"*.
- ⚠ But the office Rank 1 makes accountable — **`DATA / EVENT`** — was **constituted nowhere**. Measured
  before this ADR: **0** role-table rows and **0** §13-style constitutions naming it in
  `PRD_OWNERSHIP_MODEL.md`.

### 1.2 Why a separate ADR from `ADR-0117`

⭐ **Two distinct offices received two distinct conferrals over two distinct subjects, so they take two
ADRs.** This is the reasoning `ADR-INDEX.md` records for the `ADR-0103`/`ADR-0104` pair: *"the pass
received **two distinct one-act conferrals** … a single omnibus would have claimed one standing grant
where two per-act conferrals were made."*

⛔ Folding both offices into one ADR would blur exactly the boundary `ADR-0033` §7.1 protects — and would
also obscure that **`ADR-0117`'s act is exercisable now while this one is not** (§4.2).

---

## 2. The conferral

The human principal directed, in these words:

> *"I explicitly constitute and confer the office **'DATA / EVENT'** for **ONE ACT ONLY**: To decide and
> record the BC-30 Offline Sync queue-depth/backpressure bound required for Item 7b, **after the Item-3
> durability model is authoritative**. This is ONE ACT ONLY and NOT a standing licence. It authorizes only
> the queue-depth/backpressure decision."*

⛔ **One holder**, per §3 rule 1. ⛔ **Outside this act the office is VACANT.** ⛔ **No personal name is
recorded** (§7 rule 4).

⭐ **The role vocabulary is reused, not invented** — §2.3 is satisfied at **Rank 1**: `MASTER_PRD.md`
**L498** names **`DATA / EVENT`** verbatim as `MP-NFR-04`'s owner. ⚠ **The compound name is preserved
exactly as Rank 1 writes it** and is **not** split into two offices, because splitting it would create a
role Rank 1 does not name.

---

## 3. Scope of the authority — stated exactly

| | |
|---|---|
| **Office** | **`DATA / EVENT`** |
| **Constituted** | 2026-09-08, by direct human-principal conferral |
| **Authorized for** | **ONE ACT:** to decide and record the **`BC-30` Offline Sync queue-depth / backpressure bound** required for **Item 7b**, ⚠ **after the Item-3 durability model is authoritative** |
| **Standing authority** | ⛔ **NONE.** `ADR-0033` §7.1 |

| Role | Decides | ⛔ Does NOT decide |
|---|---|---|
| **`DATA / EVENT`** | For this act only: the `BC-30` Offline Sync **queue-depth / backpressure bound**, against `MP-NFR-04`'s backpressure obligation | ⛔ **Queue implementation** · ⛔ **storage implementation** · ⛔ **retry/backoff** (Item 5) · ⛔ **retention** (7a) · ⛔ **encryption** (9b) · ⛔ **credentials** · ⛔ **cloud resources** · ⛔ **unrelated architecture changes** · ⛔ the **durability model** (that is `ADR-0117`'s office) · ⛔ boundaries, ranks or permitted edges (**Architecture Owner**) · ⛔ scope, priority or acceptance (**Product Owner**) · ⛔ document status or freeze (**Governance Owner**) · ⛔ **its own conferral** |

⛔ **The prohibition list above is the conferring instruction's own, transcribed rather than summarised.**

---

## 4. ⛔⛔ What this ADR deliberately does NOT do

### 4.1 No value, no policy

⛔ **NO QUEUE-DEPTH VALUE OR BACKPRESSURE POLICY IS DECIDED, HINTED AT OR IMPLIED.** No limit,
high-water mark, low-water mark, shed policy, eviction rule, drop policy, block-vs-reject choice or
threshold appears anywhere in this ADR. There is no pre-approved figure anywhere in the repository to
ratify, so writing one would be **invention**.

The conferring instruction is explicit:

> *"DO NOT decide: … Item 7b queue-depth value. Those are the subsequent acts of the newly constituted
> offices."*

### 4.2 ⚠⚠ The act is CONFERRED but NOT YET EXERCISABLE — and this is stated plainly

⭐ **The conferral carries its own precondition:** *"after the Item-3 durability model is authoritative."*

Measured at this ADR's acceptance: **Item 3's durability model does NOT exist.** `ADR-0117` constituted
the `EVENT platform` office but expressly **withheld the exercise**, so no durability model is
authoritative. ⛔ **Therefore this office, though constituted, CANNOT lawfully act yet.**

⚠ **That is not a defect in this ADR — it is the instruction's own sequencing, recorded rather than
quietly dropped.** There is also a substantive reason it is right: a depth bound is a statement about a
queue whose durability properties determine what a bound even means. Bounding a queue that has no agreed
durability model would produce a number with no referent.

⛔ **Item 7b therefore remains BLOCKED behind Item 3**, and is **not** re-statused by this ADR.

### 4.3 Preserved

⛔ **`ADR-0115` and `ADR-0116` are preserved** — neither amended, superseded nor restatused; both
byte-unchanged. ⛔ **`ADR-0117` is not amended** — it is a companion act, not a parent. ⛔ **`PRD-006`,
every frozen PRD, the BC Map, `E-24`, `MASTER_PRD.md` and `DOCUMENTATION_BASELINE.md` are
byte-unchanged.** ⛔ **`PRD-018` is not created.**

---

## 5. Method: APPEND

For the reason `ADR-0117` §5 records and `PRD_OWNERSHIP_MODEL.md` §13's preamble established — that
document is cited **by line number** from `Accepted` ADRs and from `DOCUMENTATION_BASELINE.md` — this
office is constituted in a **new §15 appended below the last line**. **Every pre-existing line is
byte-identical** and **0 citations shift**.

⚠ The L6 `Version` field's pre-existing staleness is again **disclosed and not repaired** (`ADR-0077` §8
precedent). The authoritative advance to **v1.6** is recorded in this ADR's `Amends` row and in §15's own
change-history block.

⚠⚠ **Two ADRs amend the same document in one commit, and the ordering is stated so it is auditable:**
`ADR-0117` appends **§14** and takes the document to **v1.5**; `ADR-0118` appends **§15** beneath it and
takes it to **v1.6**. Because both are pure appends, neither disturbs the other's lines, and the final
file contains both sections in that order.

---

## 6. What remains open

| Item | Status after this ADR | Why |
|---|---|---|
| **7b — Queue depth** | 🔒 **BLOCKED behind Item 3** — office now exists; act **not yet exercisable** | §4.2 |
| **3 — Durable Queue** | ⛔ **OPEN** — office constituted by `ADR-0117`; decision not made | `ADR-0117` §4 |
| **9b — At-rest** | 🔒 **BLOCKED behind Item 3** | **SECURITY PLATFORM**; `ATT-GAP-006` independently OPEN |
| **5 — Retry/Backoff** | ⛔ **OPEN — untouched** | `PRD-006` **L2332** |
| **7a — Retention** | ⛔ **OPEN — untouched** | `Q-04`; `ATT-GAP-005` |
| **8b-residual** | ⚠ **REQUIRES OWNER DECISION — untouched** | Product Owner + `BC-03` Domain Owner |

⛔ **This ADR confers NO lifecycle stage**, creates **no** bounded context, edge, event, port or
requirement identifier, allocates **0** `IMPL-*`, mints **0** `SYNC-*`, and touches **0**
application-code files.

---

## 7. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-08 | ⭐⭐ **Created and ACCEPTED. The `DATA / EVENT` office is CONSTITUTED and CONFERRED FOR ONE ACT ONLY** — to decide and record the `BC-30` Offline Sync queue-depth / backpressure bound (Item 7b) — by direct human-principal conferral, on the `ADR-0077` / `ADR-0080` / `ADR-0102` precedent. Measured before the act: **0** role-table rows and **0** §13-style constitutions for `DATA / EVENT` in `PRD_OWNERSHIP_MODEL.md`. ⭐ Vocabulary **reused, not invented** — `MASTER_PRD` **L498** names `DATA / EVENT` verbatim at Rank 1; ⚠ the **compound name is preserved exactly** and deliberately **not split** into two offices, which would coin a role Rank 1 does not name. ⭐ **Written as a SEPARATE ADR from `ADR-0117`** on the `ADR-0103`/`ADR-0104` reasoning: two distinct offices, two distinct conferrals, two distinct subjects — an omnibus *"would have claimed one standing grant where two per-act conferrals were made."* ⛔⛔ **NO QUEUE-DEPTH VALUE OR BACKPRESSURE POLICY IS DECIDED, HINTED AT OR IMPLIED** — no limit, high/low-water mark, shed, eviction, drop or block-vs-reject choice; no pre-approved figure exists to ratify, so writing one would be invention. ⚠⚠ **THE ACT IS CONFERRED BUT NOT YET EXERCISABLE, AND THIS IS RECORDED RATHER THAN QUIETLY DROPPED:** the conferral is expressly sequenced *"after the Item-3 durability model is authoritative"*, and measured at acceptance that model **does not exist** (`ADR-0117` withheld its exercise) — so **Item 7b stays BLOCKED behind Item 3** and is **not** re-statused. ⛔ **Not a standing licence** (`ADR-0033` §7.1); outside this act the office is **VACANT**; **no holder appointed and no personal name recorded** (§7 rule 4); **one holder** (§3 rule 1). ⭐ **Amends `PRD_OWNERSHIP_MODEL.md` → v1.6 BY APPEND (new §15)**, beneath `ADR-0117`'s §14 in the same commit; both are pure appends so neither disturbs the other's lines; **0** citations shifted; the L6 `Version` staleness **disclosed, not repaired**. ⛔ **No baseline re-issue** — the document is **Unranked**. ⛔ **`ADR-0115`, `ADR-0116` and `ADR-0117` preserved byte-unchanged.** ⛔ **`PRD-006`, all frozen PRDs, BC Map, `E-24`, `MASTER_PRD.md`, `DOCUMENTATION_BASELINE.md` byte-unchanged; `PRD-018` not created; 0 `IMPL-*`; 0 `SYNC-*`; 0 application-code files.** |
