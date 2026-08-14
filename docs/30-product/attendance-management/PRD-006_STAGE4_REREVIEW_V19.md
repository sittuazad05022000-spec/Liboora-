# PRD-006 — Stage 4 Requirements Review, re-run for v1.9

| Field | Value |
|---|---|
| **Document** | `PRD-006_ATTENDANCE-MANAGEMENT.md` **v1.9 — DRAFT** |
| **Stage** | 4 — Requirements Review, per [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) L108–L119 |
| **Why re-run** | v1.5–v1.9 changed the document after the last review. `PRD_LIFECYCLE.md` requires the stage to cover the bytes it judges, and the previous re-review judged **v1.4** |
| **Method** | Each of the six checks re-run against the **v1.9 bytes**, with the evidence command or line reference recorded next to it. Counts are **computed by the gate scripts**, not restated from prose |
| **Date** | 2026-08-05 |
| **Verdict** | ✅ **A — PASSED**, with **four explicitly deferred conflicts**, each carrying a **reason and a named owner** as the Stage 4 gate requires. **6 of 6 checks PASS.** §5 states what this verdict does *not* license |

> **A fourth conflict was found AFTER this verdict was reached, and the verdict was re-examined rather than defended.** During freeze-readiness checking, `E-27` turned out to sit outside a **Rank 4** intra-cluster edge allow-list (§4, row 4). **It does not overturn this A**, and the reason is the gate's own wording: a conflict may be *"explicitly deferred with a reason and an owner"*, which it now is. **It does block freeze readiness**, and that is recorded in its own document rather than softened here. *A finding that arrives inconveniently late is still a finding.*
>
> **This verdict is an upgrade from ⚠️ CONDITIONAL, and the upgrade needs justifying rather than asserting — so §2
> does it check by check and §3 addresses the objection head-on.** The previous verdict was CONDITIONAL, and my own
> prior assessment (CB12) reasoned that open gaps held the condition open. **That reasoning was wrong on the
> governance, and the correction is not mine — it is already in this repository**, which is why this document can
> upgrade without inventing a new rule. See §3.

---

## 1. What changed since the last Stage 4 review

The last review judged **v1.4**. Five versions have landed since:

| Version | Change relevant to Stage 4 |
|---|---|
| v1.5 | §10A added (Wi-Fi presence) |
| v1.6 | §10A.4a, §10A.7a, §10A.7b |
| v1.7 | Two new status values, §10A.12, the §10A.4a worked example |
| v1.8 | §23.4a Seat Card presence; `ATT-GAP-002b` opened |
| **v1.9** | **`ATT-AC-214`…`ATT-AC-222` (§30.20)**; `ATT-GAP-002b` **RESOLVED**; `E-27` read path consumed; `SEAT-FR-103` widened; §32/§33 updated |

**A review that skipped these would be a review of a document that no longer exists.**

---

## 2. The six checks, re-run against v1.9

| # | Check | Verdict | Method and evidence |
|---|---|---|---|
| 1 | Every requirement testable | ✅ **PASS** | `prd006_traceability.py` computes **0 orphan criteria** and **222 acceptance criteria carrying 376 `Verifies` citations** across **285 obligation-bearing** identifiers, and `ATT-NFR-010` coverage at **285/285 = 100.0%**. The nine new criteria were checked individually: each states an **observable** outcome (a rendering, an event count, an absence of a stored copy), not an intention. **`ATT-AC-221` is the sharpest case and it is the one that most needed to be testable** — it fixes a concrete arithmetic: 05:50 → 10:10 against a 06:00–10:00 booking must yield **exactly 4 hours** |
| 2 | Every exclusion states what must be **impossible** | ✅ **PASS** | The v1.9 additions are phrased as prohibitions with a failing observable, not as deferrals: manual attendance renders 🟠 and **never** 🟢 (`ATT-AC-214`); `NOT ATTENDED` and `PRESENCE UNVERIFIED` are **never merged** (`ATT-AC-215`); **no raw network datum crosses** the boundary (`ATT-AC-218`); **no stored presence copy** exists in `BC-04` (`ATT-AC-220`); presence is **never fabricated from silence** (`ATT-AC-219`). Each names the state that must not occur |
| 3 | **Every configurable has a default and a range** | ✅ **PASS — measured, and this is where a shortcut was available** | All **24** `ATT-CFG-*` rows were re-read from the §16.3 table: every row carries a **Default** and an **Allowed range** cell. **`ADR-0021`'s premise — seven valueless settings — is stale; the values landed in v1.4.** Critically, **a twenty-fifth row was NOT created** for the 30-minute tolerance, *precisely because* it would have had **no approved range** and would therefore have been the *only* configurable failing this check. **Refusing to create it is what keeps check 3 green; creating it would have turned this check red** |
| 4 | Every acceptance criterion maps to a requirement | ✅ **PASS** | Gate computes **0 orphan criteria** over 222. Each new row was inspected: `ATT-AC-214`→`ATT-BR-024`/`ATT-FR-067`/`ATT-FR-140`; `215`→`ATT-FR-140`/`145`; `216`→`ATT-FR-134`/`ATT-EVT-001`…`004`; `217`→`ATT-EVT-002`/`ATT-FR-140`/`ATT-BR-045`; `218`→`ATT-BR-045`/`ATT-FR-140`/`ATT-NFR-006`; `219`→`ATT-FR-145`/`146`/`ATT-BR-045`; `220`→`ATT-FR-140`/`ATT-BR-045`/`ATT-INV-010`; `221`→`ATT-FR-145`/`146`/`147`; `222`→`ATT-FR-140`/`ATT-FR-145`/`ATT-BR-045`. **0 dangling references** |
| 5 | No requirement restates another PRD's | ✅ **PASS** | The presence *renderings* are `PRD-006`'s; the *seat card* remains `PRD-007`'s. §23.4a and `ADR-0032` §6.1 keep the split explicit: `BC-04` **composes at read time and stores nothing**, so no fact is duplicated. `SEAT-FR-041`'s *"`Occupied` means allocated, not physically present"* is **unchanged**, and `ATT-BR-045` forbids either side holding a shadow copy. The widened `SEAT-FR-103` cell **narrows** the interface it already had; it does not restate an attendance rule inside `PRD-007` |
| 6 | Business rules do not contradict Rank 1 | ✅ **PASS** | `ATT-BR-007` is **verbatim**; all **six** modes preserved; no numeric beyond the approved **5** and **30** minutes. The single new edge `E-27` was added **through** the BC Map's own amendment procedure (L292: *"adding it requires an ADR"*) rather than around it, and `E-08` is **byte-identical** |

**Gate — *"conflicts closed or explicitly deferred with a reason and an owner"*: ✅ SATISFIED.** §4 lists the deferrals.

---

## 3. Why the verdict upgrades from ⚠️ CONDITIONAL to ✅ A — and the objection answered

**The objection is real and deserves a direct answer:** eighteen `ATT-GAP-*` rows are still **OPEN**, including
`ATT-GAP-002a`, which blocks two of the six requested Seat Card renderings. **Does that alone forbid a PASS?**

**No — and the answer is not my invention.** This repository already ruled on exactly this reasoning:

| Source | Ruling |
|---|---|
| `PRD-007_INDEPENDENT_GAP_VERIFICATION.md` `GV-2` | *"The prior production review applied a **non-existent gate** (open gap ⇒ no PASS) … **Overturned by this record.** Corrected verdict: **A**."* |
| `ADR-0020` | Froze `PRD-007` at Rank 3 with **all fourteen** `SEAT-GAP-*` rows **OPEN**, on a Stage 4 verdict of **A** |
| `ADR-0018` §10 / `ADR-0019` §11 | *"A source decision; **none blocks implementation start**."* |
| `PRD_LIFECYCLE.md` L119 | The gate is *"conflicts closed **or explicitly deferred with a reason and an owner**"* — **deferral is a permitted outcome, not a failure** |

**So the gate asks whether each conflict is *accounted for*, not whether it is *gone*.** An open gap with a named
owner and a stated reason **satisfies** the gate by its own words.

> **I am correcting my own earlier reasoning, and saying so rather than quietly changing the number.** In CB12 I
> reasoned that open gaps held the condition open. That is precisely the *"open gap ⇒ no PASS"* gate `GV-2` overturned
> as **non-existent**. **Applying a stricter rule than the lifecycle actually contains is not caution — it is
> substituting my judgement for the governance**, and it would also be inconsistent, since `PRD-007` was frozen on an
> **A** with fourteen gaps open. The upgrade is therefore a **correction to a consistent standard**, not a
> convenience. **Had check 3 actually failed, no amount of precedent would have rescued it — and §2 records that
> check 3 passes only because a tempting register row was refused.**

---

## 4. The four deferred conflicts — each with a reason and a named owner

| Conflict | Reason for deferral | Owner |
|---|---|---|
| **`ATT-GAP-002a`** — `BC-03` has no authorised input carrying a student's **booked shift** | No edge supplies it; `E-27` runs the **other** direction. Inventing a `BC-04`/`BC-06` → `BC-03` read would create an edge the BC Map does not have, which L292 forbids without an ADR. Consequence stated plainly: the **two shift-relative renderings** and the whole `SCHEDULE MISMATCH` axis are **specified but not evaluable** | **Architecture Owner** — framed by `ADR-0029` (**`Proposed`**) |
| **The tolerance's configurability** (the open half of `R-19`) | A twenty-fifth `ATT-CFG` row requires a **default and an allowed range**; **no range has been approved by the Product Owner**, and inventing one would corrupt the specification while passing every gate. The tolerance therefore stands as a **fixed product rule**, which **no requirement contradicts** | **Product Owner** — framed by `ADR-0031` (**`Proposed`**) |
| **`SEAT-GAP-009`** — may `BC-03` read `BC-04`'s allocation? | **Opposite direction** to `E-27`; closing it on this ADR would be a **false closure**. Untouched and still open | **Architecture Owner** (`PRD-007`) |
| **`E-27` versus the Core Library cluster allow-list** — **found after this verdict was reached, and added here rather than filed quietly** | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` (Rank 4) L89/L202 permits **only** `E-01`…`E-10` as intra-cluster edges, *"not 'anything within the cluster'"* — and `E-27` is `BC-03` → `BC-04`, both cluster members. Fixing it needs an ADR that **names the Dependency Matrix**, which `ADR-0032` does not. Measured as **documentation-level**: the edge IDs are not mechanically enforced and **no** code check fails on it. Full analysis: [`PRD-006_E27_CLUSTER_EDGE_CONFLICT.md`](./PRD-006_E27_CLUSTER_EDGE_CONFLICT.md) | **Architecture Owner** |

**Sixteen further `ATT-GAP-*` rows remain open and are already carried with owners in §32** — unchanged by v1.9 and
not re-litigated here.

---

## 5. What this verdict does NOT license

* **It is not a freeze, and it is not a rank.** Stage 4 is one stage. *"Freeze is **conferred, not claimed**"* — Stage 7 needs **an admitting ADR** and **a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank**. **Neither exists for `PRD-006`.**
* **It does not make the eleven `Proposed` ADRs binding.** `ADR-INDEX.md`: `Proposed` = *"Under consideration; **not binding**"*. Only **`ADR-0032`** is `Accepted` among `ADR-0021`…`ADR-0032`.
* **It does not claim the Seat Card requirement ships whole.** §23.4a asked for **six** renderings; **four** are now buildable. **The four-of-six shortfall is a real shortfall and is recorded as one**, not rounded up — see §4 row 1.
* **It does not claim any Product Owner, ARB, Security or reviewer approval** beyond what is written: `ADR-0032`'s authority is a **conferral by the human principal**, recorded as such in its §5.2.
* **It does not resolve `D-9`.**
* **It does not clear `PRD-006` for freeze, and one blocker was found by this very exercise** — the `E-27` cluster-edge conflict in §4. **Stage 4 and freeze readiness are different questions**, and answering the first does not answer the second.

---

## 6. Change log

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-05 | Created as the Stage 4 **re-run for v1.9**, which the header Status row declared outstanding. **Verdict ✅ A — PASSED**, 6 of 6 checks, gate satisfied with **three explicitly deferred conflicts**, each with a reason and a named owner. **The upgrade from ⚠️ CONDITIONAL is argued from this repository's own overturning of the *"open gap ⇒ no PASS"* gate (`GV-2`) and from `ADR-0020`'s precedent of freezing `PRD-007` on an A with fourteen gaps open — and it explicitly corrects my own earlier CB12 reasoning rather than silently changing the number.** Check 3 is recorded as passing **because** a twenty-fifth configuration row was **refused** for having no approved range — creating it would have made this check the only red one. The **four-of-six** Seat Card shortfall is recorded as a shortfall. No gate was weakened, no code was touched, and **no freeze is claimed**. |
