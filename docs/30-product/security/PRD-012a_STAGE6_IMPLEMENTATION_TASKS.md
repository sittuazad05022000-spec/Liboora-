# `PRD-012a` Stage 6 — Implementation Tasks Gate

| Field | Value |
|---|---|
| **Act** | 📐 **MEASUREMENT** — this document records what was counted. It confers nothing. The artefact it certifies is the task document |
| **Subject** | `PRD-012a` Parts 1–8, v0.1–v0.8 `DRAFT` |
| **Part 1 hash** | `dbd01d4d00165c774024d62a9e4a18099cf4272402581a8febcf244ab582d452` — **unchanged** by this stage |
| **Part 8 hash** | `a8c45d79eb8154f766e1fe1006031ea6baacdd99439fc0cfca2d1f504e7c7977` — **unchanged** by this stage |
| **Prior stage** | Stage 5 registered at [`../../40-implementation/TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) **v1.18 §2N** |
| **Artefact produced** | [`../../40-implementation/security/PRD-012a_IMPLEMENTATION_TASKS.md`](../../40-implementation/security/PRD-012a_IMPLEMENTATION_TASKS.md) v1.0 |
| **Range allocated** | **`IMPL-1300` … `IMPL-1359`** — 60 tasks · `IMPL-1360`…`1399` declared growth reserve |
| **Authority** | **Implementation Lead**, exercised by direct, explicit and unconditional conferral of the human principal (§0) |
| **Findings** | **0 CRITICAL · 1 HIGH · 1 MEDIUM · 2 LOW** — all four *carried*, none introduced by this stage. Plus **5 self-inflicted defects in the artefact, all caught by the gate before certification** (§3.2) |
| **Carried forward** | **44** `SECP-GAP-*` still OPEN · **7** `SECP-DEP-*` unmet · **5** `SECP-ADR-*` unwritten · **8 of 60 tasks blocked** on an external decision |
| **Verdict** | ✅ **A — PASS** |
| **Stage** | 6 of 9. **Stage 7 is NOT entered by this document.** ⛔ **0 of 128 acceptance criteria are proven** |
| **Status of this record** | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md` |
| **Date** | 2026-08-21 |

---

## 0. Authority — stated, because Stage 6 has an owner

`PRD_LIFECYCLE.md` §6 assigns **Stages 6 and 8** to the **Implementation lead**. L283 records that *"Every PRD needs a
named owner. **None has one**"* (`PGA-08`), so there is no standing holder of that role for `PRD-012a`.

The authority relied on here is the same form `PRD-013_STAGE6_IMPLEMENTATION_TASKS.md` §0 and
`PRD-016_STAGE6_IMPLEMENTATION_TASKS.md` §0 used: direct, explicit and unconditional conferral by the human principal,
scoped to one act. The instruction was to take `PRD-012a` *"through the repository's lifecycle from Stage 2 through
Stage 7"* while *"following the repository's authoritative lifecycle exactly."* **That instruction is the authority, and
it is the only authority claimed.**

**Scope: this act only.** `ADR-0033` §7.1 — *"A conferral for one act is not a standing licence."* It confers nothing
about **Stage 7, which belongs to the Governance Owner** (`PRD_LIFECYCLE.md` §6 L282), and it does not cure `PGA-08`:
`PRD-012a` still has no standing named owner after this record exists.

⚠ **The instruction named Stage 6 "CONFERRAL". The repository's Stage 6 is "Implementation Tasks."** Conferral is what
Stage 7 *is*. The same instruction said *"Do NOT assume the lifecycle steps. Follow the repository's authoritative
lifecycle exactly,"* which resolves the divergence in the repository's favour. This record is named for the
repository's stage, not the instruction's label.

---

## 1. What the gate required, and what exists

`PRD_LIFECYCLE.md` Stage 6, verbatim:

> **Gate:** an `IMPL-*` range allocated and a task document in which **every task traces back to requirements**.

Both halves exist. A range is allocated (**`IMPL-1300` … `IMPL-1359`**, 60 contiguous numbers) and a task document
exists in which **every one of 60 tasks traces back to requirements** — verified by recomputation, not asserted. All
four allocation rules are met, each measured separately in §2.

**Two notes on the instructions this stage sits inside.**

**(a) `IMPL-*` allocation is explicitly required here.** The standing instruction not to register identifiers
prematurely applies except where the lifecycle explicitly requires it. Stage 6's gate **is** that explicit requirement;
this is the one stage at which allocation is not merely permitted but mandatory.

**(b) No file was modified that the gate did not require.** **Two files were created.** Nothing else was touched — not
any of the eight PRD Parts, not the matrix, not the registry, not the baseline, not `PRD_LIFECYCLE.md`, not
`tool/module_dependencies.yaml`, not another module's backlog, and not one line under `lib/`, `test/` or `packages/`.

---

## 2. The gate clause by clause — measured

| ID | Clause | Rule | Measurement | Result |
|---|---|---|---|---|
| **`G1`** | An `IMPL-*` range is allocated | Gate, first half | `IMPL-1300`…`IMPL-1359`, **60** contiguous numbers, parsed from the table; span has no internal gaps; **0** duplicates | ✅ |
| **`G2`** | A task document exists | Gate, second half | `PRD-012a_IMPLEMENTATION_TASKS.md` v1.0, **60** task rows parsed from §5, **0** malformed rows | ✅ |
| **`G3`** | Every task traces back to requirements | Gate, the **operative** clause | **60 of 60** Requirements cells non-empty. In the Requirements column specifically: `SECP-FR` **84/84**, `SECP-BR` **25/25**, `SECP-XC` **37/37**, `SECP-HRO` **12/12**, `SECP-SIG` **10/10**, `SECP-SEV` **4/4**, `SECP-TST` **8/8** — **missing = [] on all seven**. **0** tasks cite an undefined identifier; **0** cite a `SECP-GAP-*` or `SECP-AC-*` as an obligation | ✅ **after the §3.2 correction** |
| **`G4`** | Take the next free range; never reuse or reassign | Rule 1 | **610** distinct `IMPL-*` enumerated across `docs/ tool/ lib/ test/ packages/`. **0** tasks defined below `IMPL-1300`, **0** inside `IMPL-1261`…`1299`, **0** duplicates, **0** outside the span. The single prior `IMPL-1300` string occurrence is a **boundary label** at `PRD-017_IMPLEMENTATION_TASKS.md:98`, disclosed rather than filtered | ✅ |
| **`G5`** | Leave the previous group room to grow contiguously | Rule 2 | `IMPL-1200`…`1260` is `PRD-017`'s and `IMPL-1261`…`1299` its **declared reserve** (39 remaining); starting at `1300` leaves that reserve wholly intact. `IMPL-1360`…`1399` declared as **this** module's reserve for 44 open `SECP-GAP-*` | ✅ |
| **`G6`** | Record `Priority`, `Blocks`, `Blocked by` per task | Rule 3 | 60 of 60 carry a valid `P1`/`P2`/`P3` — **36 / 23 / 1**; **141 edges**; `Blocks` and `Blocked by` reconciled in both directions; **0 cycles**; **1 root** (`IMPL-1300`), **1 leaf** (`IMPL-1359`); longest chain **14** | ✅ **after the §3.2 correction** |
| **`G7`** | Traceability table: group → requirements → **invariants** → acceptance | Rule 4 | §6 present, seven waves, **all four columns**. `SECP-AC` **128 of 128** mapped. ⚠ The invariants column is **empty with a published reason** — see §2.2 | ✅ **with a disclosed structural limit** |
| **`G8`** | Published graph figures are true | Not in the rule — added because §7 publishes numbers | All figures recomputed from the parsed table and required to match. **Four did not match on first writing** and were corrected — §3.2 | ✅ **after correction** |

### 2.1 Reproducible

```
grep -rhoE 'IMPL-[0-9]{3,4}' docs/ tool/ lib/ test/ packages/ | sort -u | wc -l   → 610
grep -rnoE 'IMPL-1[3-9][0-9]{2}' docs/ tool/ lib/ test/ packages/                → 1 boundary label + this backlog
git status --short lib/ packages/ test/ tool/                                     → 0 lines
sha256sum docs/30-product/security/PRD-012a_SECURITY_AUTOMATION.md               → dbd01d4d…82d452  (unchanged)
sha256sum docs/30-product/security/PRD-012a_PART8_TRACEABILITY_AND_ACCEPTANCE.md → a8c45d79…7c7977  (unchanged)

task rows parsed: 60 · range 1300..1359 contiguous: True · dups: 0 · malformed: 0
priority: P1=36 P2=23 P3=1 · edges: 141 · cycles: 0 · roots: [1300] · leaves: [1359] · longest chain: 14
SECP-FR 84/84 · SECP-BR 25/25 · SECP-XC 37/37 · SECP-HRO 12/12 · SECP-SIG 10/10 · SECP-SEV 4/4 · SECP-TST 8/8
SECP-AC mapped in §6 wave table: 128/128 · missing: []
SECP-INV-nnn minted: 0 · SECP-CFG-nnn minted: 0 · SECP-EVT-nnn minted: 0
```

### 2.2 `G7`'s invariants column is empty, and the gate passes anyway — why

Allocation rule 4 names four columns. Three are populated; **invariants is empty, because `SECP-INV-*` has zero
members** — deliberately, per `SECP-GAP-010`: an invariant requires an aggregate to be invariant over, and
`SECP-FR-084` disclaims ownership of any aggregate.

The gate was assessed on the honest reading rather than the convenient one. **Two options existed**: leave the column
empty with a published reason, or mint invariants so the table looked complete. **Minting would have been the more
serious defect** — `PRD_LIFECYCLE.md` §5 rule 6 forbids extending a closed register without an ADR, and
`SECP-BR-025` states that *"a citation is not a declaration, and a 'not declared' note must not mint an identifier."*
A backlog inventing four invariants to fill a column would have manufactured exactly the class of defect the
`PGA-01`/`PGA-02` precedent exists to prevent.

**Verified: `SECP-INV-nnn` appears 0 times in the artefact.** So do `SECP-CFG-nnn` and `SECP-EVT-nnn`, the other two
deliberately-empty registers.

⚠ **The properties that would be invariants elsewhere are enforced as exclusions instead** — `SECP-XC-001`,
`SECP-XC-003`, `SECP-XC-004`, `SECP-XC-014` via `IMPL-1301`, `1302`, `1303`, `1318`, proven as wholes by `IMPL-1359`.
The enforcement exists; only the register naming it does not. **This is recorded as a disclosed structural limit of the
subject, not as a pass the artefact did not earn.**

---

## 3. Findings

### 3.1 Carried forward — none introduced by this stage

| ID | Finding | Severity | Owner |
|---|---|---|---|
| `S6-4` | **Stage 1's gate was never met.** `PRD-012a` holds no `BC-nn`; the Bounded Context Map has **87** rows and no security context. The backlog neither cures nor contradicts it | **HIGH** | Architecture Owner, via `SECP-ADR-001` |
| `S6-2` | **8 of 60 tasks blocked** on an Architecture Owner or `BC-18` owner decision — chiefly the absent `platform/security:` block under `default_decision: deny`. The backlog is complete but **not startable in full** | **MEDIUM** | Architecture Owner, via `SECP-ADR-004` / `SECP-DEP-003` |
| `S6-1` | `PRD_LIFECYCLE.md`'s Stage 6 allocation table is **stale** — it ends at `IMPL-227` + "Unallocated" while **610** distinct `IMPL-*` exist and eight module backlogs sit above it. **Not corrected**: Rank 1, and baseline §7 rule 1 requires an ADR before the change | **LOW** | Governance Owner |
| `S6-3` | The rule-4 invariants column is empty because `SECP-INV-*` is empty by design. §2.2 | **LOW** | — |

**Nothing in this table was created by Stage 6.** `S6-4`, `S6-2` and `S6-3` are restatements of `SECP-GAP-041`,
`SECP-GAP-042` and `SECP-GAP-010`, all declared by the subject itself at Stage 2. `S6-1` is a Rank 1 defect this stage
observed and declined to fix.

### 3.2 Five self-inflicted defects — caught by the gate, before certification

**The artefact was wrong five times, and the gate is why this record can say so precisely.**

| ID | Defect | Published | Actual | Consequence had it stood |
|---|---|---|---|---|
| `I6-1` | `P1`/`P2`/`P3` distribution | `28 / 30 / 2` | **`36 / 23 / 1`** | A false figure in a gate-checked cell |
| `I6-2` | Dependency edges | `112` | **`141`** | Understated coupling by 26% |
| `I6-3` | Longest chain | `7` | **`14`** | Halved the critical path |
| `I6-4` | **14 obligations cited only in `Scope`/`Test` cells, not the `Requirements` column** — `SECP-XC-021`/`025`/`026`/`028`/`032`/`036` and **all eight** `SECP-TST-*` | "146 of 146" | **132 of 146** where the gate reads them | ⛔ **A false gate pass.** `G3` is the operative clause; a reader trusting the total would have believed the gate met when it was not |
| `I6-5` | The §4.1 total was stated before the column audit | `146` | `146` — **right for the wrong reason** | Correct by luck, not by measurement |

**`I6-4` is the one that matters.** It was not a typo: the exclusions and test classes *were* genuinely cited, and every
one had a real task — but they were cited in the columns a human reads rather than the column the gate measures. Six
task rows were amended so the claim is true where it is checked. **After the amendment all seven registers report
`missing = []`.**

**How it was caught:** by parsing the document's own table and recomputing every published figure, including expanding
`` `X-001`…`012` `` range notation — the same ellipsis form that produced instrument defect `I-1` at Stage 4, here
producing the mirror-image error in the *document* rather than the *tool*.

⚠ **The working rule, now stated in both directions.** Stage 4 established: *when a broad automated check accuses a
heavily-reviewed document, verify the instrument first.* Stage 6 establishes its converse: **when a document publishes a
number, recompute it before certifying it.** Four of five graph figures here were wrong on first writing. A gate that
only re-read prose would have passed all five.

**No `PRD-012a` Part was edited to fix any of them.** Both subject hashes are unchanged. Every correction was to the
artefact this stage produced.

---

## 4. What this record does **not** confer

| It does not | Because |
|---|---|
| Enter Stage 7 | Stage 7's gate is **a row in `DOCUMENTATION_BASELINE.md` §3**, and *"freeze is conferred, not claimed"* |
| Change the registry status | `PRD_REGISTRY.md` §4.1 L260 still reads `PLANNED`. This stage writes nothing there |
| Cure the Stage 1 gate | `SECP-GAP-041` is open; only `SECP-ADR-001` can close it |
| Close any `SECP-GAP-*` | 44 remain open. A backlog schedules; it does not decide |
| Meet any `SECP-DEP-*` | All 7 remain unmet. Five belong to the Architecture Owner or a `BC-nn` owner |
| Write, number or accept any ADR | 5 `SECP-ADR-*` remain *requests*. `ADR-0060` is the next free number and **is not taken here** |
| Declare `platform/security`'s outbound ports | `SECP-DEP-003`. Editing the manifest would let the module grant itself permissions |
| Prove any acceptance criterion | **0 of 128.** Stage 9 proves criteria; Stage 6 maps them |
| Authorise any code change | Stage 8 is not started. `git status --short lib/ packages/ test/ tool/` → 0 lines |
| Correct `PRD_LIFECYCLE.md`'s stale table | Rank 1. Baseline §7 rule 1 requires an ADR **before** the change |
| Extend any closed register | `SECP-HRO-*`, `SECP-SIG-*`, `SECP-SEV-*`, `SECP-TST-*` are closed. §5 rule 6 requires an ADR |

---

## 5. Verdict

| Clause | Result |
|---|---|
| `G1` range allocated, contiguous | ✅ `IMPL-1300`…`1359`, 60 tasks |
| `G2` task document exists | ✅ v1.0, 60 rows parsed |
| `G3` **every task traces back to requirements** | ✅ 146/146 obligations in the Requirements column, after `I6-4` |
| `G4` next free range, nothing reused | ✅ 610 enumerated, 0 reassigned |
| `G5` previous group's reserve intact | ✅ `IMPL-1261`…`1299` untouched |
| `G6` `Priority`, `Blocks`, `Blocked by` on every task | ✅ 60/60, 141 edges, 0 cycles |
| `G7` rule-4 traceability table | ✅ with the invariants column empty **and its reason published** |
| `G8` published figures true | ✅ after four corrections |

**✅ A — PASS. Stage 6 of 9 is met.**

**Stage 7 is not entered.** Its gate is a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank, and that
row does not exist. Whether it *should* is a Governance Owner decision, not a measurement — and not this record's to
make.

---

## 6. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-21 | Created. Records Stage 6 **PASS** for `PRD-012a` on eight measured clauses `G1`–`G8`. Certifies [`PRD-012a_IMPLEMENTATION_TASKS.md`](../../40-implementation/security/PRD-012a_IMPLEMENTATION_TASKS.md) v1.0, allocating **`IMPL-1300`…`IMPL-1359`** — 60 contiguous tasks plus reserve `IMPL-1360`…`1399` — computed from **610** enumerated `IMPL-*`, leaving `PRD-017`'s reserve `IMPL-1261`…`1299` intact per rule 2. `G3`, the operative clause, verified as **146/146 obligations** (84 `SECP-FR-*` + 25 `SECP-BR-*` + 37 `SECP-XC-*`) cited **in the Requirements column**, all seven registers reporting `missing = []`; **128/128** `SECP-AC-*` mapped; **0 proven**. Rule 3 verified as **60/60 priorities, 141 edges, 0 cycles, 1 root, 1 leaf, longest chain 14**. `G7` passes with the **invariants column empty and its reason published** — `SECP-INV-*` has zero members by design (`SECP-GAP-010`), and §2.2 records why minting four would have been the graver defect; verified `SECP-INV-nnn`, `SECP-CFG-nnn` and `SECP-EVT-nnn` each appear **0** times. **§3.2 discloses five self-inflicted defects in the artefact, all caught by recomputing its own published figures** — including `I6-4`, **14 obligations cited only in `Scope`/`Test` cells rather than the gate-measured `Requirements` column, which would have been a false gate pass**; six task rows were amended and no PRD Part was touched. Carries `S6-1`…`S6-4`: Stage 1's gate unmet (**HIGH**), 8 blocked tasks (**MEDIUM**), `PRD_LIFECYCLE.md`'s stale `IMPL-227+` table and the empty invariants column (**LOW**). **Confers nothing** — no Stage 7 entry, no registry write, no gap closed, no dependency met, no ADR written or numbered, no port declared, no register extended, no criterion proven, no code touched. Subject hashes unchanged: Part 1 `dbd01d4d…82d452`, Part 8 `a8c45d79…4e7c7977`. |
