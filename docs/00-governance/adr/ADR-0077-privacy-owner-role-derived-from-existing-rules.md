# ADR-0077 — The **Privacy Owner** role is derived into `PRD_OWNERSHIP_MODEL.md` because five existing rules already require it

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-25 |
| **Date** | 2026-08-25 |
| **Deciders** | **Architecture Review Board**, acting through the **Architecture Owner** role defined in `PRD_OWNERSHIP_MODEL.md` §2.2 and §2.3 (L85, L102) — and specifically under **§5**, which states that *"**Only the Architecture Owner approves**"* a Rank 1–5 document change, the rule L284 records. Authority **expressly conferred for this one decision**; `ADR-0033` §7.1 — not a standing licence over the ownership model |
| **Supersedes** | — |
| **Amends** | `docs/00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md` (**Rank 1–5 governance artefact**) → **v1.2** — §2.1 derivation table (one row added), §2.2 role table (one row added), §2.3 vocabulary table (one row added), §2 closing sentence (*"Four roles"* → **five**, with the arithmetic restated), §5 stage-obligation table (one row added), §8 changelog. **No existing role removed, renamed, merged or re-scoped. No existing role's `Decides` or `Does not decide` cell altered.** Executed, see §6 |
| **Amended by** | — |
| **Baseline** | **No baseline re-issue.** `PRD_OWNERSHIP_MODEL.md` is a governance artefact, not a **Rank 1–3** document; `DOCUMENTATION_BASELINE.md` §7 step 4 moves the baseline identifier *"only when a Rank 1–3 document changes version"*. `ADR-0055` and `ADR-0016` record the identical exemption. §7 steps 1–2 **are** engaged and are honoured: this ADR precedes the change, and the document's version and changelog move in the same commit |
| **Closes** | The **role-existence** blocker only — the state in which `LCR-DEC-003` / `LCR-GAP-006` (and `TSF-GAP-016`, `SEAT-GAP-014`, `LIB-24.2`) were routed to an authority the repository **did not define**. See §5.1 |
| **Does NOT close** | ⛔ **`LCR-DEC-003`, `LCR-GAP-006`, `TSF-GAP-016`, `SEAT-GAP-014`, `LIB-24.2`, `ARCHITECTURE_RULINGS.md` L290 Public Live Occupancy, `DOCUMENTATION_BASELINE.md` L317, or any other item awaiting a privacy review.** **Constituting a role is not exercising it.** No privacy review is performed, approved, waived or pre-judged here. Also does **not** close the parallel **`Governance Owner`** defect — see §4.2 |
| **Related** | `PRD_OWNERSHIP_MODEL.md` **§2.1** (the derivation method this ADR applies), **§2.2**, **§2.3** (*"Role vocabulary is reused, not invented"*), **§3** rule 1, **§5**, **§7** rule 4 (*"**Never** record a personal name"*) · `ARCHITECTURE_RULINGS.md` **L290** (Rank 5) · `Library_PRD_v1.md` **L1025** (`LIB-24.2`, Rank 3, **FROZEN**) · `PRD-020_TRUST_AND_SAFETY.md` **L1784** (`TSF-GAP-016` — the verbatim prior use) · `PRD-SEAT-MANAGEMENT.md` **L2266** (`SEAT-GAP-014`) · `DOCUMENTATION_BASELINE.md` **L317** · `PRODUCT_IMPLEMENTATION_ROADMAP.md` **L226** · `IMPLEMENTATION_ROADMAP.md` **L561** · `ADR-0011` (three deciders for one decision — the separability precedent) · A3 `LCR-RS-007`, `LCR-GAP-006`, `LCR-DEC-003` |

> ✅ **ACCEPTED 2026-08-25. The migration in §6 has been executed.**
>
> ⭐ **This ADR does not invent a role. It records one the repository has been routing decisions to
> for months without defining.** §2.2 shows the role is **derived by `PRD_OWNERSHIP_MODEL.md`
> §2.1's own method** — the method that produced the existing four — and that the document's
> *"a fifth would have no rule to serve"* clause is satisfied because **five rules serve it**, one
> of them at **Rank 5** and one inside a **FROZEN Rank 3** PRD.

---

## 1. Context

### 1.1 The blocker, stated exactly

`PRD-021A` Part A3 routes two items to a **Privacy Owner**:

| Item | Routed to |
|---|---|
| `LCR-GAP-006` — per-viewer impression tracking would create a new personal-data store over a minor-inclusive population (`SM-INV-3`; BC Map **L376**) | **Privacy Owner + Product Owner** |
| `LCR-DEC-003` — *"Is per-viewer impression tracking permissible for this population?"* | **Privacy Owner + Product Owner** |

Measured at HEAD `c563931`:

```
grep -c "Privacy Owner" docs/00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md   →  0
```

`PRD-021A_OWNER_DECISION_REQUEST.md` §5 therefore recorded these items as ⛔ **NOT REQUESTABLE**
and **deliberately offered no signature block**, on the ground that *"there is no defined
authority to sign it."* That was the correct refusal. It also left the items permanently
unresolvable, over a population the repository itself flags as minor-inclusive.

### 1.2 ⭐ The rule that makes adding a role look unlawful

`PRD_OWNERSHIP_MODEL.md` **§2.1** does not merely list roles — it **derives** them, from a table
whose columns are *"Existing rule | Question it forces | Role that answers it"*, and then closes:

> *"Four distinct answers. **Four roles is therefore the minimum** — not a choice of granularity,
> but the number the existing rules already imply. **A fifth would have no rule to serve**; a
> third would leave one of the six rows above unanswerable."*

Read naively, adding a fifth role contradicts a governance document. **That reading is what this
ADR tests, and it fails on measurement.** §2.1's clause is **conditional**, not absolute: a fifth
role is excluded *if and only if* no rule serves it. It is a **test**, and the test is now met.

---

## 2. Decision

### 2.1 What is decided

**The `Privacy Owner` role is recorded in `PRD_OWNERSHIP_MODEL.md`**, by the same §2.1 derivation
that produced the existing four, with:

- **Accountable for** — privacy posture of personal-data processing, including the completed
  privacy review that five existing rules already require before certain designs may proceed.
- **Decides** — whether a proposed processing of personal data is permissible, and whether a
  required privacy review is discharged.
- **Does not decide** — business scope or priority (Product Owner), boundaries, ranks or edges
  (Architecture Owner), domain-model correctness (Domain Owner), or implementation approach
  (Technical Owner).

The document moves **v1.1 → v1.2**, and §2's closing arithmetic is restated from four to **five**.

### 2.2 ⭐ The derivation — five existing rules, none of them created here

Applying §2.1's own table format. **Every row below existed before this ADR:**

| Existing rule | Rank | Question it forces | Role that answers it |
|---|---|---|---|
| `ARCHITECTURE_RULINGS.md` **L290** — Public Live Occupancy is *"**Deferred — V2.** Requires a completed privacy review before design … **must not be invented**"* | **5** | Who performs and completes the privacy review? | **Privacy Owner** |
| `Library_PRD_v1.md` **L1025** (`LIB-24.2`) — *"Public Live Occupancy **MUST NOT** be implemented until a privacy [review]"* | **3**, **FROZEN** | Who lifts the prohibition? | **Privacy Owner** |
| `PRD-020_TRUST_AND_SAFETY.md` **L1784** (`TSF-GAP-016`) — *"Routed to the **Architecture Owner** and **the privacy owner** jointly."* | — | Who is the second addressee? | **Privacy Owner** |
| `PRD-SEAT-MANAGEMENT.md` **L2266** (`SEAT-GAP-014`) — owner recorded as *"Architecture + privacy review"* | — | Who owns the privacy half? | **Privacy Owner** |
| `DOCUMENTATION_BASELINE.md` **L317**, `PRODUCT_IMPLEMENTATION_ROADMAP.md` **L226**, `IMPLEMENTATION_ROADMAP.md` **L561** — *"Deferred pending a privacy review"* | — | Who ends the deferral? | **Privacy Owner** |

**Five distinct rules, one distinct answer, and none of the existing four roles can supply it:**

| Existing role | Why it cannot absorb this | Source |
|---|---|---|
| **Product Owner** | *"Decides whether a requirement is correct and in scope"*, **not** whether processing personal data is lawful. `TSF-GAP-016` addresses the privacy owner **alongside** an existing role, which is only meaningful if they differ | §2.2 |
| **Architecture Owner** | `TSF-GAP-016` names the Architecture Owner **and** the privacy owner *"jointly"* — the repository already distinguishes them. `SEAT-GAP-014` writes *"Architecture **+** privacy review"* for the same reason | §2.2, L1784, L2266 |
| **Domain Owner** | Scoped to *"correctness of the PRD **within its bounded contexts**"*. A privacy review of a minor-inclusive population spans contexts | §2.2 |
| **Technical Owner** | Decides *"sequencing and technical approach"*, explicitly **not** *"whether a requirement is right"* | §2.2 |

⇒ **§2.1's test is satisfied.** A fifth role now has **five** rules to serve, so the minimality
clause — which excludes a role only when *no* rule serves it — does not bar it. **The role is
derived by the document's own method, not appended to its output.**

### 2.3 ⭐ §2.3's vocabulary-reuse constraint is satisfied

§2.3 requires that *"**Every role name below already appears in the repository.** This document
adopts the existing vocabulary rather than introducing a parallel one."* Measured:

| Role | Prior use in the repository |
|---|---|
| **Privacy Owner** | **`PRD-020_TRUST_AND_SAFETY.md` L1784 — *"the privacy owner"*, verbatim.** Plus *"privacy review"* as the act at `ARCHITECTURE_RULINGS.md` L290, `Library_PRD_v1.md` L1025, `PRD-SEAT-MANAGEMENT.md` L2266, `DOCUMENTATION_BASELINE.md` L317, `PRODUCT_IMPLEMENTATION_ROADMAP.md` L226, `IMPLEMENTATION_ROADMAP.md` L561 · `ADR-0010` L110 · `ADR-0027` L167 · `PRD-004_INDEPENDENT_REVIEW_REPORT.md` L498 · `14B-Public-Library-Preview.md` L122 |

**No new vocabulary is introduced.** The name is lifted from L1784, capitalised to match the
document's four existing role names.

### 2.4 What is **NOT** decided — read this before citing this ADR

⛔ **Constituting a role is not exercising it.** This ADR:

| Does not | Consequence |
|---|---|
| Perform any privacy review | Every deferral cited in §2.2 stays deferred |
| Approve, waive or pre-judge `LCR-DEC-003` / `LCR-GAP-006` | A3 `LCR-RS-007` **Already-seen suppression** stays **⏸ DEFERRED** |
| Lift `LIB-24.2` or `ARCHITECTURE_RULINGS.md` L290 | Public Live Occupancy stays deferred. ⛔ **A FROZEN Rank 3 PRD is not touched** |
| Name a person | `PRD_OWNERSHIP_MODEL.md` §7 rule 4 — *"**Never** record a personal name"*. Honoured |
| Assign an incumbent | §3 rule 1 requires one holder each; **naming the holder is not this ADR's act** |
| Grant the role approval power over Rank 1–5 documents | §5 is unchanged: *"**Only the Architecture Owner approves**"* |
| Create the `Governance Owner` role | A real, parallel defect — **disclosed, not fixed**. §4.2 |

⭐ **Nothing about the substance of any privacy question is settled here.** A2 and A3 remain
**NOT READY — NOT FROZEN**.

---

## 3. Alternatives considered and rejected

| # | Option | Rejected because |
|---|---|---|
| 1 | **Re-route the items to the Product Owner** | §2.2 scopes the Product Owner to *"whether a requirement is correct and in scope"*. It would also contradict `TSF-GAP-016`, which addresses the privacy owner **jointly with** an existing role, and `SEAT-GAP-014`'s *"Architecture **+** privacy review"*. The repository has already distinguished them |
| 2 | **Re-route to the Architecture Owner** | Same objection, sharper: L1784 names **both**, so collapsing them edits an existing routing rather than serving it |
| 3 | **Leave the items permanently unresolvable** | The honest posture *before* a ruling, and exactly what the Owner Decision Request §5 recorded. It is untenable *after* an instruction to constitute the role, and it strands a minor-safety question indefinitely |
| 4 | **Invent an approval and sign it** | ⛔ Refused. The instruction was explicit: *"establish the Privacy Owner role; invent no approval without it."* §2.4 |
| 5 | **Create the role without an ADR** | `DOCUMENTATION_BASELINE.md` §7 step 1 — *"a change to any Rank 1–5 document requires an ADR **before** the change"* |
| 6 | **Also create the `Governance Owner` role in this ADR** | Same defect class, but **not** in the instruction set, and it has its own derivation to perform. Bundling it would exercise conferred authority beyond its grant (`ADR-0033` §7.1). **Disclosed instead** — §4.2 |
| 7 | **Rewrite §2.1 to drop the minimality clause** | Unnecessary and destructive. The clause is a **test**, and the test is met; deleting it would remove the very discipline that makes this derivation lawful |

---

## 4. Consequences

### 4.1 Positive

- Five existing rules across three ranks gain a defined authority. Before this, `ARCHITECTURE_RULINGS.md`
  L290 (**Rank 5**) demanded *"a completed privacy review"* from nobody.
- `LCR-DEC-003` / `LCR-GAP-006` become **requestable** — routed to a defined role rather than a
  vacuum, with the minor-safety question intact.
- §2.1's derivation method is **exercised** rather than overridden, so the next role question has a
  worked precedent.

### 4.2 ⚠ Disclosed, not repaired — the parallel `Governance Owner` defect

```
grep -c "Governance Owner" docs/00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md   →  0
```

**`Governance Owner` is equally undefined**, yet it is:

- the approving authority recorded in **`ADR-0053`**, **`ADR-0054`** and **`ADR-0064`**; and
- the routing target of **`LCF-GAP-001`**, **`LCF-GAP-008`** and **`LCR-GAP-001`**.

⭐ This is **more serious** than the privacy gap, because the privacy gap blocked decisions while
this one has already **conferred** them — three `Accepted` ADRs name an approver the ownership
model does not define. It is **the same defect class** and it is **deliberately left open**: it is
outside the instruction, and remedying it would require its own §2.1 derivation and its own ADR.
**Recorded here so it is not mistaken for an oversight.**

### 4.3 Negative / accepted costs

- ⚠ §2's headline arithmetic changes from four to five. Any document quoting *"four roles"* becomes
  stale. Measured: the phrase occurs in `PRD_OWNERSHIP_MODEL.md` only, and is corrected there.
- ⚠ The role has **no named incumbent** (§2.4). It is constituted but unfilled — which is the
  honest state, and better than the prior state of being neither.

### 4.4 Neutral

- No code, test, gate or Rank 1–4 architecture artefact is affected.

---

## 5. Scope limits

### 5.1 Closed

| Item | Basis |
|---|---|
| The **role-existence** blocker — items routed to an undefined authority | The role is defined |
| `PRD-021A_OWNER_DECISION_REQUEST.md` §5's ⛔ **NOT REQUESTABLE** status | Becomes requestable. **Not answered** |

### 5.2 ⛔ Explicitly left open

Every privacy question named in §2.2 — `LCR-DEC-003`, `LCR-GAP-006`, `TSF-GAP-016`,
`SEAT-GAP-014`, `LIB-24.2`, `ARCHITECTURE_RULINGS.md` L290, `DOCUMENTATION_BASELINE.md` L317 —
plus the `Governance Owner` defect (§4.2). **No readiness and no freeze is conferred on anything**;
`PRODUCT_IMPLEMENTATION_ROADMAP.md` **L161–164** independently gates `PRD-021` behind `PRD-020`.

---

## 6. Migration — executed

| Step | Action | State |
|---|---|---|
| 1 | This ADR raised and accepted **before** the change (`DOCUMENTATION_BASELINE.md` §7 step 1) | ✅ |
| 2 | §2.1 — one derivation row added, sourced to `ARCHITECTURE_RULINGS.md` L290 (Rank 5) | ✅ |
| 3 | §2 closing sentence — *"Four distinct answers … Four roles"* restated to **five**, with the *"no rule to serve"* test shown as **met** rather than deleted | ✅ |
| 4 | §2.2 — one role row added (`Accountable for` / `Decides` / `Does not decide`). **Four existing rows byte-unchanged** | ✅ |
| 5 | §2.3 — one vocabulary row added, citing `PRD-020` **L1784** as the verbatim prior use | ✅ |
| 6 | §5 — one stage-obligation row added. *"Only the Architecture Owner approves"* **unchanged** | ✅ |
| 7 | §8 changelog — v1.2 entry; header version **v1.1 → v1.2**, same commit (§7 step 2) | ✅ |
| 8 | Baseline identifier **not** advanced (§7 step 4) | ✅ |

---

## 7. Compliance record

| Check | Result |
|---|---|
| Role invented, or derived? | ✅ **Derived** — §2.2, five pre-existing rules, by §2.1's own method |
| §2.1's *"a fifth would have no rule to serve"* respected? | ✅ Yes — it is a **conditional test**, and it is **met**. The clause is preserved, not deleted |
| §2.3's *"vocabulary is reused, not invented"* respected? | ✅ Yes — *"the privacy owner"* is verbatim at `PRD-020` **L1784** |
| Any privacy approval invented, implied or pre-judged? | ✅ **No** — §2.4. Every deferral stays deferred |
| Personal name recorded? | ✅ **No** — §7 rule 4 honoured |
| Existing role altered? | ✅ **No** — all four rows byte-unchanged, including every `Decides` / `Does not decide` cell |
| Approval authority redistributed? | ✅ **No** — §5's *"Only the Architecture Owner approves"* is untouched |
| Frozen artefact touched? | ✅ **No** — `Library_PRD_v1.md` (`LIB-24.2`) read as authority, byte-unchanged |
| Rank 1–4 architecture artefact amended? | ✅ No — `MASTER_PRD.md`, BC Map, EA, `ARCHITECTURE_RULINGS.md` byte-unchanged **by this ADR** |
| Baseline identifier advanced? | ✅ No |
| Pre-existing defect search performed? | ✅ Performed, **did NOT return empty** — the `Governance Owner` gap (§4.2). **Disclosed, not repaired** |
| Readiness / freeze claimed? | ✅ **No** — §5.2 |
