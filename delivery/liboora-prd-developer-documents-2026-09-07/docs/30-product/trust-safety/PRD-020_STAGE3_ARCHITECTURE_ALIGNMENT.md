# `PRD-020` Trust & Safety — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review** (`PRD_LIFECYCLE.md` L87–102) |
| **Subject** | [`PRD-020_TRUST_AND_SAFETY.md`](PRD-020_TRUST_AND_SAFETY.md) — `BC-13` Trust & Safety, **v0.1 header / v0.5 content, `DRAFT`** |
| **Gate** | *"a written alignment record naming every conflict and its disposition"* |
| **Gate satisfied by** | §1 (six mandated checks, each measured) + §2 (dispositions) + §3 (rejected findings) |
| **Subject sha256** | `4c719dbf7904a07a8619ab6459f0f8e39dd79a4d603d153b44b3e536b3bbd90b` — ⛔ **unchanged by this review** |
| **Reviewer role** | Architecture reviewer (`PRD_LIFECYCLE.md` §6). ⚠ **No named holder exists** — `PGA-08` |
| **Measured at** | `4509705` |
| **Date** | 2026-08-22 |
| **Mandate** | **Stage 3 only.** ⛔ No ADR created · no identifier registered in any matrix · **no Rank 1–5 document touched** · no registry or baseline update · no freeze · no rank assigned · no code changed |
| **Verdict** | ✅ **PASS — 6 of 6 mandated checks.** 0 defects requiring an edit · **2 governance dependencies remain open** (§2) · **2 candidate findings raised and REJECTED with reasons** (§3) |

> `PRD_LIFECYCLE.md` L41–42: *"A gate is not an opinion — if the artefact does not exist, the stage has not
> been passed, however complete the work feels."* This document is that artefact for Stage 3.

---

## 0. Method, and its limits

Each of the six checks in `PRD_LIFECYCLE.md` Stage 3 is measured against the authority the
lifecycle names for it, with the command or line reference given so the measurement can be
repeated. Where the subject and the authority disagree, the conflict is named and given a
disposition. Where a candidate finding turned out **not** to be a defect, it is recorded as
rejected (§3) — because *"a review that records only accepted findings is indistinguishable
from a review that found nothing."*

⚠ **Disclosed limit.** This review reads the specification against Ranks 1–5. It does not
re-verify the implementation; `IMPL-1410` is measured separately in
[`PRD-020_IMPL-1410_IMPLEMENTATION_EVIDENCE.md`](../../40-implementation/trust-safety/PRD-020_IMPL-1410_IMPLEMENTATION_EVIDENCE.md)
and that record is **not** treated here as evidence about the document.

---

## 1. The six mandated checks

| # | Check | Authority | Measured | Verdict |
|---|---|---|---|---|
| 1 | Context ownership is exclusive | BC Map §3 | BC Map **L117** assigns `BC-13` Trust & Safety, `[CORE]`, Global Student, V1. `PRD_REGISTRY.md` **L320** names `PRD-020` as its sole claimant. **No second PRD claims `BC-13`** | ✅ |
| 2 | Every integration edge exists in BC Map §7 | *"If an edge is not in this table, it does not exist"* | PRD-020 cites `E-13`, `E-14`, `E-15`, `E-16`, `E-19`, `E-20`, `E-22`, `E-23`, `E-27`, `E-28`. BC Map §7 holds `E-01`…`E-26`. ⭐ `E-27`/`E-28` are cited **only to record that PRD-020 deliberately did NOT allocate them** — see §3 finding R-1 | ✅ |
| 3 | Rank direction is downward | Dependency Matrix `L2` | `dart run tool/check_module_boundaries.dart` → **`social` = 0 violations**. The 9 reported violations are the pre-existing `app → domain/library` set, dated `ADR-0012` debt, unrelated to `BC-13` | ✅ |
| 4 | No authorisation decided outside `BC-18` | `X-13` — *"a security defect that passes its own tests"* | `TSF-XC-017` (**L215**) refuses to introduce a fourth authorization scope, citing `MP-GBR-21`'s closed register `self`/`guardianOf`/`tenantWide`. `TSF-FR-012` (**L418**): T&S **MAY** request step-up; *"the decision and mechanism remain `BC-18`'s"* | ✅ |
| 5 | No credential, OTP or session outside `BC-18` | `ID-1` | `TSF-XC-002` (**L200**) explicitly disclaims credentials, sessions, OTP, roles, permissions and consent, quoting `ID-1`. **L408** restates the ownership guard | ✅ |
| 6 | Tenant scoping correct | `MP-GBR-08`, `X-13`; `MP-RSK-01` Critical | ⭐ **The strongest result in this review.** `F-1` (**L92**) states *"`BC-13` may not hold `tenantId`"*, citing BC Map **L488** and `module_dependencies.yaml` **L266–267**. `TSF-INV-015` (**L1212**) forbids inventing a tenant-shaped scope. **L369** routes tenant records to `BC-19`. `TSF-BR-014` (**L802**) requires cases resolvable *without* T&S reading tenant data | ✅ |

### 1.1 Why check 6 deserves the emphasis

`MP-RSK-01` is **Critical** and the failure mode the lifecycle names is a cross-tenant leak.
`BC-13` is a *global* context that acts upon *tenant-scoped* ones, which is precisely the
shape in which a tenancy leak is easiest to introduce and hardest to see. PRD-020 does not
merely avoid `tenantId` — it states the prohibition as a **foundational constraint** (`F-1`),
enforces it as an **invariant** (`TSF-INV-015`), reflects it in the **exclusion register**
(`TSF-XC-017`), and designs case resolution so the prohibition is *survivable*
(`TSF-BR-014`). The machine-enforced manifest agrees: the boundary checker reports zero
`social` violations.

⚠ Note for the record: the strings `MP-GBR-08` and `MP-RSK-01` do **not** appear in PRD-020.
This is **not** recorded as a defect — the lifecycle requires the tenant scoping to *be*
correct, not the risk identifiers to be cited. The substance is present under `F-1`/`ID-2`.
Whether Rank 1 risk identifiers should be cited by name is a **documentation-convention**
question for the Requirements reviewer, and it is passed to Stage 4 rather than decided here.

---

## 2. Open governance dependencies — named, dispositioned, NOT closed

These are conflicts between the subject and its authorities that **this review has no power
to close**. Each is recorded with its owner, per the gate's requirement that every conflict
receive a disposition.

| # | Dependency | Nature | Owner | Disposition |
|---|---|---|---|---|
| D-1 | **`TSF-GAP-003` implementation half** — `IMPL-1410` is built and measured, but *closing* the gap is a governance act | Architecture-half **CLOSED** by `Accepted` `ADR-0065` (**L693**, **L1820**); implementation half **OPEN** | **Architecture Owner** | ⛔ **Left OPEN.** The `ADR-0055` → `ADR-0059` precedent makes closing an implementation half a **separate Architecture-Owner ADR**. Next lawful number: **`ADR-0074`** (`ADR-0066`–`0073` are earmarked by §29.2; `ADR-0069` marked *DO NOT OPEN*) |
| D-2 | **`TSF-GAP-014`** — age band for a `PersonId` derives from `BC-18` consent state (`ID-6`); **no authority specifies an accessor** (**L272**) | A missing cross-context accessor | **`BC-18` owner with `BC-13` owner** | ⛔ **Left OPEN.** Specifying an accessor would author into `BC-18`, which `PRD-020` does not own |

⚠ **Neither dependency blocks Stage 3.** Stage 3 validates the specification against Ranks
1–5; both D-1 and D-2 are correctly *disclosed* by the subject rather than silently assumed
away, which is what the gate asks of a draft. They **do** bind Stage 7 — see the Stage 7
readiness record.

### 2.1 Gaps carried, not resolved

The subject declares **16** gap identifiers (`TSF-GAP-001`…`016`). Their states are the
subject's own and are neither advanced nor retired by this review:

| State | Members |
|---|---|
| Architecture half closed, implementation half open | `TSF-GAP-003` |
| Resolved by **V1 scope reduction**, recorded not deleted | `TSF-GAP-012`, `TSF-GAP-015` (rows 1, 2, 4) |
| **OPEN**, routed to a named owner | `TSF-GAP-001`, `002` (Architecture + Product Owner, per `TSF-XC-051` **L1478**), `005`, `006`, `008`, `009`, `014`, `016` |

⭐ **`TSF-GAP-012` and `TSF-GAP-015` are worth a note because they demonstrate the V1/V2
boundary being *preserved* rather than expanded.** Both were resolved by **reducing** V1
scope and **recording** the deferred analysis so *"V2 inherits the analysis rather than
rediscovering it"* (**L1173**). That is the correct disposition shape, and this review
neither reopens nor extends it.

---

## 3. Candidate findings RAISED and REJECTED, with reasons

| # | Candidate finding | Why it was rejected |
|---|---|---|
| **R-1** | ⚠ *"PRD-020 cites `E-27` and `E-28`, but BC Map §7 ends at `E-26`. Per the gate, an edge not in the table does not exist — therefore two phantom edges."* | ⛔ **REJECTED — the opposite is true, and this was the most serious-looking candidate in the review.** Reading the citations: **L2636** *"Did not allocate `E-28` or any edge identifier — no new edge exists to name. `E-27` stays **withdrawn** by `Accepted` `ADR-0033`"*; **L2673** *"Allocating `E-28` would presuppose Option A."* The subject cites these numbers **to record its own restraint**, and correctly applies `PRD_LIFECYCLE.md` §5 rule 5 (*"Numbers are never reused, even after withdrawal"*). A checker that flags this would be **penalising a document for documenting a prohibition** — the same error class the `_codeOnly()` convention exists to avoid |
| **R-2** | *"`BC-13` has exactly one edge and it is outbound (`F-3`, BC Map **L318**) — no inbound edge, no port. A `[CORE]` context with no inbound edge cannot be integrated."* | ⛔ **REJECTED — this is the approved architecture, not a defect.** BC Map **L286** states the rationale directly: *"`BC-13` acts *on* other contexts, not beside them … capabilities that would create cycles if modelled as normal peer calls. Resolution: T&S publishes"* events. `E-14` is event-only fan-out and each context **self-restricts**; *"T&S never writes into them"* (**L318**). The single-outbound-edge shape is the **cycle-avoidance mechanism**. Reclassifying it as a defect would reinterpret an existing Rank 4 decision, which this review is forbidden to do |

---

## 4. What this record does NOT do

| Act not performed | Owner | Why |
|---|---|---|
| Close `TSF-GAP-003` or any gap | Architecture Owner | Requires `ADR-0074`; `ADR-0065` L424 confines its conferral to *"**this** decision only"*, and `ADR-0033` L169: *"a conferral for one act is not a standing licence"* |
| Assign a rank / advance status | Governance owner | Stage 7 act |
| Register identifiers in `TRACEABILITY_MATRIX.md` | Traceability owner | Stage 5 act |
| Edit the subject | Product owner | ⭐ **This review found no defect requiring an edit.** Subject hash is byte-identical before and after |
| Create or amend any ADR, BC Map, Matrix or `module_dependencies.yaml` entry | Architecture Owner | Verified: `git diff` over `docs/00-governance/`, `docs/10-architecture/` and `tool/` is **0 lines** |

---

## 5. Change history

| Version | Date | Change |
|---|---|---|
| 1.0 | 2026-08-22 | Created. Stage 3 gate artefact: 6 of 6 mandated checks measured and passed; 2 open governance dependencies dispositioned to named owners; 2 candidate findings rejected with reasons. **Subject unmodified.** |
