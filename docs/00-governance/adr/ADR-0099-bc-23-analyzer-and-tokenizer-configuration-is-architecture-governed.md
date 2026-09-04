# ADR-0099 — The `BC-23` analyzer and tokenizer configuration is an **Architecture-Owner-governed artefact**, and its **values are NOT supplied here**

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-04 |
| **Date** | 2026-09-04 |
| **Deciders** | **Architecture Owner** — the office that `PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L101** already names as the owner of *"Analyzer configuration"*, and that `PRD-015_SEARCH_INDEXING.md` **L843** already names as the owner of `SRCH-GAP-002`. Exercised by **direct, explicit conferral of the human principal of this engagement, scoped to this act**, whose instruction reads verbatim: *"**Create the necessary architecture decision record for HD-6**"* and *"The analyzer/tokenizer configuration must be explicitly governed by a new architecture decision record."* The mechanism is the one `ADR-0080` **§2.4** establishes and that `ADR-0053`, `ADR-0054`, `ADR-0064`, `ADR-0086`, `ADR-0087`, `ADR-0092`, `ADR-0093`…`ADR-0098` have each already exercised. ⛔ **No standing appointment is created** — `ADR-0033` **§7.1**, *"a conferral for one act is not a standing licence."* ⛔ **No ARB quorum, attendee list, sign-off date, Security review or Privacy Owner review is asserted.** ⛔ **No personal name is recorded** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 |
| **Subject** | The **analyzer and tokenizer configuration** of `BC-23 Search Indexing` — the artefact that `PRD-015_SEARCH_INDEXING.md` **§36** carries as blocker **`P2`** and that `SRCHPO-5` deliberately left undefined |
| **Amends** | [`ADR-INDEX.md`](./ADR-INDEX.md) — one register row and the `Count` cell (**L9**), both in the same commit as this file |
| **Baseline** | ⛔ **NOT re-issued.** `BASELINE-2026-09-03-A` stands. `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier only for a **Rank 1–3** document *changing version*; **0** documents at any rank change version here, and `BASELINE-2026-08-20-C`'s own changelog fixes that *"an ADR being **added** is not a Rank 1–3 document **changing version**"* |
| **Rank / Precedence** | **Rank 2** (Accepted ADR) |
| **Closes** | The **authority limb** of `PRD-015` §36 blocker **`P2`** — *what governs the analyzer/tokenizer configuration* — recorded as **`HD-6`** in [`PRD-015_FINAL_BLOCKER_RESOLUTION.md`](../../30-product/search/PRD-015_FINAL_BLOCKER_RESOLUTION.md) |
| **Does NOT close** | ⛔⛔ **The configuration itself.** No analyzer is named. No tokenizer is named. No engine is named. No folding table, normalization table, `ZWJ`/`ZWNJ` exception list, stop-word list, stemmer, edit-distance bound, minimum token length, minimum prefix length or vocabulary is supplied. ⛔ `SRCH-GAP-002` is **not** closed. ⛔ `SRCH-GAP-007` is **not** closed. ⛔ Stage 3 is **not** conferred. ⛔ `PRD-015` is **not** frozen, baselined or ranked |
| **Subject hash** | `PRD-015_SEARCH_INDEXING.md` sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` — ⭐ **byte-unchanged by this ADR** |
| **Related** | `ADR-0094` (§14A **is** the V1 `BC-23` discovery contract — the declaratory precedent this ADR's shape follows), `ADR-0017` (`BC-25` configuration ownership), `ADR-0080` (the office), `ADR-0033` (one-act conferral), `ADR-0051` §2.4 / `ADR-0016` (*a default would be a determination by a document with no standing to make it*), `AR-1` / `AR-3` (`ARCHITECTURE_RULINGS.md`), `MP-CON-01` (no vendor name in domain code) |

---

## 1. Context — what was actually missing, and what was not

`PRD-015_SEARCH_INDEXING.md` **§36** registers eight architecture blockers. **`P2`** is
*analyzer / tokenizer configuration*. Three separate records have now measured its state, and
they agree:

| Record | Measurement |
|---|---|
| `PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L74** | `SRCHPO-5` leaves the tokenizer **deliberately** undefined — a refusal, not an omission |
| `PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L101** | *"Analyzer configuration … │ **Architecture Owner** │ ⛔ NO"* — the **office is already assigned**; the Product Owner expressly does not hold it |
| `PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L109-113** | *"⛔ It does not supply the folding table itself, which is P2"* |
| `PRD-015_FINAL_BLOCKER_RESOLUTION.md` §3.5 | **No authority stronger than `SRCHPO-5` exists anywhere in the repository**; ⛔ **0** engines and **0** tokenizers named |

⭐ **So the office was never the gap.** `L101` had already assigned it. What was missing is an
**act** by that office — and `SRCHCL-X1` of `PRD-015_STAGE3_CLOSURE_ASSESSMENT.md` **L425**
states the distinction this ADR turns on: *"**an office is not an act** … Having an owner is
limb C's precondition, not limb C."*

⚠ **This ADR is that act, and it is deliberately narrow.** It settles **who governs the
configuration and under what constraints**. It does **not** settle **what the configuration
is**, because nothing in the repository supplies that and the principal's instruction forbids
inventing it: *"Do NOT select an engine or tokenizer merely because it is popular."*

### 1.1 ⭐ Why an ADR was the required instrument, and not a PRD edit

Four measured grounds, not a preference:

1. **`ADR-INDEX.md` Process step 1** — *"A decision that changes structure, ownership, a
   boundary, or a platform-wide rule requires an ADR **before** implementation."* Fixing where
   a `BC-23` configuration artefact is governed is an ownership statement.
2. **`SRCHPO-X8`** already **⛔ REJECTED** *"`PRD-015` should be edited to record the decision"*
   on five measured grounds. That refusal is honoured here: the subject is byte-unchanged.
3. **`PRD-015` is `DRAFT` and registry-`PLANNED`** (`PRD_REGISTRY.md` **L315**). A Stage-2 draft
   cannot be the authority for its own architecture blocker.
4. **`ADR-0094` is the precedent for the shape** — it recognised an authority that already
   existed and **edited nothing**. This ADR does the same for a governance locus.

---

## 2. Decision

### 2.1 The governance locus

⭐ **The analyzer and tokenizer configuration of `BC-23` is an artefact governed by the
Architecture Owner, and it MUST be established by an express architecture act before
implementation.**

It is **not** established by:

| ⛔ Not by | Ground |
|---|---|
| An engine's or library's **default** | `ADR-0051` §2.4 / `ADR-0016`: *"a default would have been a legal determination by a document with no standing to make one"* |
| **Popularity** of a tokenizer or engine | The principal's express instruction for `HD-6` |
| An **implementer's** choice at build time | `ADR-INDEX.md` Process step 1 — *before* implementation |
| **`BC-25 Configuration`** | ⚠ Distinguished, not excluded — see §2.4 |
| **Inference from indexed content** | `SRCHAO-F5 = Option A`: *"Analyzer MUST NOT infer/detect script from content"* |
| A **learned model** | `SRCH-BR-011` |

### 2.2 ⭐ The constraints any configuration MUST satisfy — stated without stating the configuration

These are **derived from existing authority**, not minted here. They bind whatever values a
later act supplies, and they are the substance of this ADR: the solution space is narrowed
even though no value is chosen.

| # | Constraint | Existing authority |
|---|---|---|
| **C-1** | **Index/query symmetry.** The same configuration MUST be applied *"identically at index time and at query time, by the same declared rule set"* | `SRCH-FR-023` (**L414**) |
| **C-2** | **Totality and symmetry of the rule set** | `SRCH-BR-008` (**L427-429**) — *"symmetric and total"* |
| **C-3** | **Script binding is consumed, never inferred.** The configuration MUST consume an **authoritative declared script**; it MUST NOT detect script from content; index and query MUST use the **same** authoritative script source | ⭐ `SRCHAO-F5 = Option A` — already **CLOSED**, recorded at `PRD-015_F5_CLASSIFICATION_DECISION_PACKET.md` §11 |
| **C-4** | **Script-aware application.** Normalization rules are applied according to the field's authoritative declared script | ⭐ Human decision `HD-2` — recorded at `PRD-015_HUMAN_DECISION_RESOLUTION_RECORD.md` |
| **C-5** | **Counting unit is the grapheme cluster** wherever the configuration expresses a length | ⭐ Human decision `HD-5` — *ibid.* ⛔ Not `SCFG-1`, not `SCFG-6`, not any storage limit |
| **C-6** | **Vendor-neutral expression.** The configuration MUST be expressible without a vendor name in domain code; engines sit behind ports | `MP-CON-01`; `MP-CON-03` |
| **C-7** | **Tenant partitioning is not weakened.** No configuration choice may weaken tenant isolation or admit tenant-private content to the public index | `MP-GBR-08`, `SE-1`, `X-13`, `AR-3`, `SRCH-INV-002`, `SRCH-INV-004` |
| **C-8** | **Language scope is the closed set of two.** The configuration MUST NOT presuppose a third canonical language or index | `SRCHPO-1`; ⭐ `HD-16` |
| **C-9** | **No language detection.** The configuration MUST NOT introduce a language-detection capability | `SRCHPO-2` — *"⛔ Do not invent language detection"* |
| **C-10** | **Declared, not emergent.** The configuration MUST be a **declared rule set** readable as a document, not a property discovered from a running system | `SRCH-FR-023`'s *"declared rule set"* |

⭐⭐ **`C-1` deserves emphasis, because it is the one constraint that a later configuration act
can violate by accident.** A tokenizer chosen for the index and a different one applied at query
time is the classic asymmetry, and `SRCH-BR-008` makes it a **business-rule breach**, not a
performance defect.

### 2.3 What is expressly left OPEN

⛔ **This ADR supplies no value.** The following remain **OPEN** and are routed, not closed:

| Open item | Routed to |
|---|---|
| The analyzer, by name or by specification | A later Architecture Owner act, under §2.1 and §2.2 |
| The tokenizer, by name or by specification | *ibid.* |
| The Devanagari normalization rule content (`HD-3`'s *"other explicitly authorized normalization rules"*) | *ibid.*, evidence-bound |
| The `ZWJ`/`ZWNJ` exception set and the `N6`×`N4` ordering (`HD-4`) | *ibid.*, evidence-bound to the applicable Unicode/product authority |
| The variant/abbreviation vocabulary (`HD-16`) | `SRCH-GAP-007`, split owner |
| Edit-distance bound, minimum token length (`HD-7`) | `SRCH-GAP-002` / `P3` |
| Minimum prefix length (`HD-8`) | `SRCH-GAP-002` / `P4` |

⚠ **That the list is this long is the honest result.** An ADR that named a tokenizer here would
have closed seven items with one unevidenced sentence.

### 2.4 ⚠ `BC-25 Configuration` — distinguished, not excluded

`ADR-0017` gives `BC-25` ownership of configuration **parameters and their validation**, and
`PRD-023` is **FROZEN** at Rank 3. A reader could conclude that the analyzer configuration
therefore belongs to `BC-25`. It does not, and the distinction is measured:

1. **`BC-25` owns parameter *carriage and validation*, not the *semantics* of a search rule
   set.** The `PRD-012a` precedent is exact — `SECP-CFG-*` was admitted **EMPTY** because
   *"`BC-25` owns parameters and validation"*, and yet the security *semantics* stayed with the
   security specification.
2. **`LCFG-6` and `LCFG-12` are the shape `BC-25` carriage actually takes** for `BC-23`
   (`CONFIGURATION_GUIDE.md` **L356**, **L362**) — single scalars with a range and a tier. An
   analyzer rule set is not that shape.
3. ⭐ **A later act MAY route individual scalars to `BC-25`.** Nothing here forecloses it. What
   is foreclosed is treating `BC-25`'s existence as having *already* decided the rule set —
   which would close `P2` by side effect, on an absence.

⛔ **`PRD-023` is byte-unchanged. No `LCFG-*` or other `BC-25` parameter is created, amended or
reserved by this ADR.**

---

## 3. Consequences

### 3.1 What becomes possible

- `P2`'s **authority limb** is closed, so a later configuration act has a lawful home and a
  stated constraint set, and does not have to re-litigate ownership.
- `C-3` gives `SRCHAO-F5 = Option A` its **consuming side**. Option A said the analyzer *must
  consume an authoritative declared script*; this ADR binds the configuration to that.
- `SRCH-FR-024`'s *"where compatible with the field's declared script and language scope"*
  acquires a governed referent for *"declared script"* once the `HD-1` mechanism supplies the
  per-field binding.

### 3.2 What remains blocked, and why that is correct

- ⛔ **`SRCH-GAP-002` remains OPEN.** Its owner is the Architecture Owner and its subject is
  *all eight* `P1`…`P8` parameters. One of eight limbs receiving a governance decision does not
  close a gap defined over the set.
- ⛔ **Stage 3 remains NOT CONFERRED.** `ADR-0033` §7.1 governs: the conferral that produced
  *this* ADR was for *this act*. It is not a Stage-3 conferral, and `SRCHCL-X1` forbids reading
  it as one.
- ⛔ **`PRD-015` remains `DRAFT` / `PLANNED`.** `PRD_REGISTRY.md` **L315** is unchanged.

### 3.3 ⚠ A dependency this ADR cannot discharge

`C-3` and `C-4` both require an **authoritative declared script per field**. `HD-1` decides the
**mechanism** that will carry it — the PO-style declaration record on the `SRCHPO-A3` precedent
— but ⛔ **the per-field binding values do not yet exist**, measured at **0 hits repository-wide**
for any script-declaration mechanism (`PRD-015_FINAL_BLOCKER_RESOLUTION.md` §2.2).

⭐ **Stated plainly: this ADR is lawful and complete as a governance act, and the configuration
it governs is not yet implementable.** Those are two different facts and collapsing them would
be the error `SRCHPO-A2` warns about.

---

## 4. ⛔ What this ADR does NOT do — enumerated

| ⛔ | Not done |
|---|---|
| Analyzer named | **0** |
| Tokenizer named | **0** |
| Search engine or vendor named | **0** |
| Normalization / folding table supplied | **0** |
| `ZWJ`/`ZWNJ` exception list supplied | **0** |
| Numeric threshold, bound, length or budget supplied | **0** |
| Vocabulary content supplied | **0** |
| Bounded contexts created or renamed | **0** — contexts stay **31**, ⛔ no `BC-32` |
| BC Map edges added, removed or amended | **0** — `LIBOORA_BOUNDED_CONTEXT_MAP.md` **byte-unchanged**; ⛔ no `BC-23` → `BC-18` edge (`SRCHPO-X4` remains **REJECTED**) |
| APIs, endpoints, events or payloads defined | **0** |
| `IMPL-*` identifiers created | **0** |
| Application-code files touched | **0** lines under `lib/`, `packages/`, `test/`, `web/` |
| Requirement identifiers minted or amended | **0** — no `SRCH-*`, `LCFG-*`, `SCFG-*`, `AUTH-*` |
| Frozen documents amended | **0** — `Library_PRD_v1.md` (incl. **§14A**), `PRD-023`, `PRD-013`, `PRD-017`, `PRD-002`, `MASTER_PRD.md`, the Enterprise Architecture, `ARCHITECTURE_RULINGS.md`, `PRD_OWNERSHIP_MODEL.md`, `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md` all **byte-unchanged** |
| Accepted ADRs' decision text overwritten | **0** — `ADR-0016`, `ADR-0017`, `ADR-0033`, `ADR-0051`, `ADR-0080`, `ADR-0094` read as **authority** and left byte-unchanged |
| Reserved ADR numbers consumed | **0** — `ADR-0088`, `ADR-0089`, `ADR-0090` remain **RESERVED and UNWRITTEN**, verified at **0 files each by an exact-filename loop, not a glob** (⚠ a class such as `ADR-008[890]*` also matches `ADR-0080`) |
| Lifecycle stages conferred | **0** — Stage 3 NOT conferred; Stages 4–7 NOT entered |

---

## 5. ⚠ Citation cost of the register row — measured before the insert

The `ADR-0099` row is inserted **after L121** — the `ADR-0098` row, the last row of the register
table — so every line from **L122** onward shifts down by exactly **one**.

**Every currently-valid line citation into `ADR-INDEX.md` sits above the insert and is
UNAFFECTED**, enumerated mechanically across all of `docs/` and `tool/` rather than assumed:
**L9** (the `Count` cell, edited strictly in place), **L50** (`ADR-0016`, cited by `PRD-017`),
**L75** (`ADR-0041`), **L84** (`ADR-0059`), **L95–L99** (cited by `PRD-012a_STAGE7_FREEZE.md`),
**L110**/**L111** (A8's drift sentences), **L114**, **L115** and **L121**.
⭐ **0 currently-valid citations are invalidated by this insert.**

⚠ **The two long-stale citation families below the insert are NOT repaired here**, for the
reason `ADR-INDEX.md` has now recorded seven times: *"`ADR-INDEX.md` L143"* in twenty places,
*"L150"*, *"L138"* and *"Process step 1, L87"* all point at the Process step-1 rule, which
measurement places at **L162** and which this insert moves to **L163** — the **eighth link** in
the `L143 → L147 → L150 → L151 → L152 → L156 → L157 → L161 → L163` chain. ⛔ **Routed to
`ADR-0075` §8.5 Option B, not silently repointed**, because the citing set includes **retained
superseded drafts** whose bytes are the record of what those drafts actually said.

### 5.1 ⚠⚠ A NEW instance of an OPEN defect class, disclosed and deliberately NOT repaired

`DOCUMENTATION_BASELINE.md` **§4**'s Rank 2 cell (**L248**) reads *"**72 accepted**"*. This ADR
takes the measured figure to **73**, so that cell becomes **stale on this commit**.

⛔ **It is NOT edited here, and the reason is an express instruction of this pass**, whose
integrity clause requires *"baselines unchanged"*. Editing the baseline declaration to repair a
derived count would breach a direct instruction in order to correct a cell that **confers no
authority** — §4 confers rank by identifier, never by count, so a stale count misinforms a
reader without changing what binds.

⭐ **It is therefore recorded as a new instance of the already-OPEN class `GCP-25`**
(*"derived statements drift behind their subjects as a class"*), whose own row states the
precedent exactly: three instances repaired, **seven disclosed and deliberately not repaired,
because they belong to other passes and other owners.** The repair is a **Governance Owner** act
on the baseline document, and it is routed there with both values named — **72 → 73** — so any
later pass can perform it in one edit.

⚠ **`ADR-INDEX.md`'s own `Count` cell at L9 IS updated**, because that cell's subject is the
register this ADR must be registered in, and leaving it stale would make this file an
**unregistered ADR** — a defect that register's own instrument detects.

---

## 6. Alternatives considered and rejected

| Alternative | Why rejected |
|---|---|
| **Name a widely-used analyzer/tokenizer and be done** | ⛔ The principal's express instruction. Also `MP-CON-01` — and a name in a Rank 2 ADR would become the vendor lock `MP-CON-02` is written to prevent |
| **Route the whole rule set to `BC-25` and close `P2`** | ⛔ §2.4 — `BC-25` owns carriage and validation; treating its existence as the decision closes `P2` on an **absence**, the error `ADR-0096` §1.2 refused |
| **Adopt the engine's default once an engine is deployed** | ⛔ `ADR-0051` §2.4 — a default is a determination by a document with no standing. Also inverts `ADR-INDEX.md` Process step 1: the decision would follow implementation |
| **Write nothing; leave `P2` to Stage 8** | ⛔ The office was already assigned (`L101`) and the act was expressly conferred. `SRCHCL-X1`: an office without an act leaves limb C unmet indefinitely |
| **Fold `P2` into an omnibus ADR closing `P1`…`P8`** | ⛔ `ADR-0033` §7.1 — one conferral is not a standing licence. Only `HD-6` was conferred as an ADR; `P1`, `P3`, `P4`, `P7`, `P8` were expressly deferred or routed |
| **Take the counting unit from `SCFG-1` / `SCFG-6`** | ⛔ Foreign-PRD **storage** lengths from `Student_Identity_PRD_v1.md`. `C-5` rests on the principal's `HD-5`, expressly recorded as a product/architecture decision and not a reuse |
| **Derive the exception set from Unicode directly** | ⛔ `HD-4` — *"Unicode behavior को अपने-आप product authority मत मानो."* Unicode is an input to a decision, not the decision |

---

## 7. Verification performed for this ADR

| # | Check | Result |
|---|---|---|
| **V1** | `PRD-015_SEARCH_INDEXING.md` sha256 unchanged | ✅ `fe3093e6…c2c4544` |
| **V2** | `ADR-0099` is the next lawful number; reserved numbers untouched | ✅ `0088`/`0089`/`0090` = **0 files each**, exact-filename loop; `0099` = **0 files** before this write |
| **V3** | ADR status counts re-derived from the files, longest-first, explicit unparsed bucket | ✅ pre-change **86 / 72 / 13 / 1 / 0 / 0**, sum closes, unparsed **EMPTY** |
| **V4** | In-principle bucket reported **by name** | ✅ `ADR-0075` |
| **V5** | `Proposed` set re-enumerated as the **same thirteen** | ✅ `ADR-0021`…`ADR-0031`, `ADR-0038`, `ADR-0041`; ⚠ **`ADR-0022` AGAIN not promoted** — nothing here tests the `E-22`/`BC-03` question it frames |
| **V6** | Frozen documents byte-identical | ✅ `git diff` names **0** frozen files |
| **V7** | BC Map byte-identical; **0** edges changed | ✅ |
| **V8** | **0** analyzers, tokenizers, engines, tables, thresholds, budgets or vocabularies named | ✅ |
| **V9** | **0** `IMPL-*`; **0** code lines | ✅ |
| **V10** | Every identifier cited pre-exists | ✅ verified individually |
| **V11** | Baseline identifier unmoved; stale §4 count **disclosed and routed**, not edited | ✅ §5.1 |
| **V12** | Citation cost measured **before** the insert | ✅ §5 — **0** valid citations invalidated |

---

**END OF ADR-0099.** ⛔ The analyzer is not named. The tokenizer is not named. The engine is not
named. What is decided is **who governs them, and under what ten constraints** — and that is the
whole of it.
