# ADR-0100 — The `BC-23` V1 search-parameter decisions: analyzer **contract**, normalization **policy**, typo bound, prefix bound, stale-serving posture and rebuild-mode selection are **DECIDED**; the **NFR budget limbs are NOT**

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-04 |
| **Date** | 2026-09-04 |
| **Deciders** | **Architecture Owner** — the office `PRD-015_SEARCH_INDEXING.md` **L980** already names as owner of `SRCH-GAP-002` and **L985** as joint owner of `SRCH-GAP-007`. Exercised by **direct, explicit conferral of the human principal of this engagement, scoped to this act**, whose instruction reads verbatim: *"Perform ONE consolidated Architecture Owner decision-resolution pass"*, *"If `ADR-0099` requires an Architecture Owner decision for this contract, record this decision through that authority"*, and *"If the governing locus is Architecture Owner under `SRCH-BR-012`, record the decision there."* The mechanism is the one `ADR-0080` **§2.4** establishes and that `ADR-0093`…`ADR-0099` have each exercised. ⛔ **No standing appointment is created** — `ADR-0033` **§7.1**, *"a conferral for one act is not a standing licence."* ⛔ **No ARB quorum, attendee list, Security review or Privacy Owner review is asserted.** ⛔ **No personal name is recorded** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 |
| **Subject** | Six of the seventeen `SRCH-GAP-002` / `SRCH-GAP-007` parameter limbs that lie **within Architecture Owner competence** |
| **Amends** | [`ADR-INDEX.md`](./ADR-INDEX.md) — one register row and the `Count` cell (**L9**), both in the same commit as this file |
| **Baseline** | ⛔ **NOT re-issued.** `BASELINE-2026-09-03-A` stands. `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier only for a **Rank 1–3** document *changing version*; **0** documents at any rank change version here |
| **Rank / Precedence** | **Rank 2** (Accepted ADR) |
| **Relationship to `ADR-0099`** | ⭐ **This ADR does NOT supersede, amend or restatus `ADR-0099`.** `ADR-0099` decided *who governs* the analyzer/tokenizer configuration and expressly withheld the values. This ADR supplies **six** of the values that office may lawfully supply, under `ADR-0099` **§2.3**'s own routing — *"a later Architecture Owner act, under §2.1 and §2.2."* `ADR-0099`'s status remains **Accepted** and its bytes are **unchanged** |
| **Closes** | `P2-A` architecture-contract limb · `P2-C` **policy** limb · `P3` · `P4` · `P8-B` posture and ordinary-freshness limbs · `P8-D` |
| **Does NOT close** | ⛔⛔ **`SRCH-GAP-002` as a whole, and `SRCH-GAP-007` as a whole.** ⛔ **`P1` transport-binding limb** (see §3.1 — ⭐ a limb the conferring instruction did not address). ⛔ `P7` latency reconciliation, `P7` **availability**, `P7` throughput numeric. ⛔ `P8-C` verifiability. ⛔ `P2-C` exception-set **content** and `N6`×`N4` **ordering**. ⛔ Vocabulary content. ⛔ Field-level **script values**. ⛔ **Stage 3 is NOT conferred.** ⛔ `PRD-015` is **not** frozen, baselined, ranked or advanced from `PLANNED` |
| **Subject hash** | `PRD-015_SEARCH_INDEXING.md` sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` — ⭐ **byte-unchanged by this ADR** |
| **Related** | `ADR-0099` (the office and the routing), `ADR-0094` (§14A **is** the V1 `BC-23` discovery contract), `ADR-0033` §7.1 (one-act conferral), `ADR-0080` (the office), `ADR-0079` (EA is Rank 6 and *records* determinations, never makes them), `MP-CON-01`/`MP-CON-02` (vendor neutrality), `MP-NFR-01` (⭐ availability owner is **SRE / OBSERVABILITY**), `LIB-20.1` (frozen NFR-locus rule) |

---

## 1. Context — what this act may decide, and what it measurably may not

`ADR-0099` §2.3 routed seven items to *"a later Architecture Owner act."* This is that act. It was
conferred fourteen human decisions and it records **six** as decided.

⭐⭐⭐ **The load-bearing sentence, placed first so the flattering reading is unavailable.** The
conferring instruction predicted `P1 = CLOSED`, `P7 latency = 2 s / 5 s`, `P7 availability = 99.9%` and
`P8-C = 30 minutes`. **Three of those four predictions do not survive measurement**, and one of them
fails for a reason **the instruction never contemplated**. This ADR records the failures rather than
the predictions.

---

## 2. Decisions

### 2.1 `D-1` — `P2-A`: the analyzer/tokenizer **architecture contract** (closes the architecture-level limb)

The V1 logical query pipeline is:

> `QUERY` → **script-aware Unicode normalization** → **grapheme-cluster-aware tokenization** →
> **exact / token / prefix / typo matching**

Binding properties:

| # | Property | Authority it satisfies |
|---|---|---|
| a | The expression is **vendor-neutral**. ⛔ No engine, analyzer product, tokenizer product or library is named | `MP-CON-01`, `MP-CON-03`, `ADR-0099` `C-6` |
| b | Normalization and tokenization **consume** the declared script scope; they **never infer** it | `SRCHAO-F5` Option A, `ADR-0099` `C-3` |
| c | ⛔ `BC-23` **MUST NOT** perform authoritative language or script detection | `SRCHPO-2`, `ADR-0099` `C-9` |
| d | Counting is by **grapheme cluster** | `HD-5`, `ADR-0099` `C-5` |
| e | Index-time and query-time analysis are **symmetric** | `SRCH-FR-023`, `SRCH-BR-008`, `ADR-0099` `C-1`/`C-2` |
| f | The pipeline is **declared**, not emergent from an implementer's build-time choice | `ADR-0099` `C-10`, §2.1 |

⛔ **Deployment-specific configuration remains separate and is NOT supplied here** — no folding table,
stop-word list, stemmer or engine-specific analyzer definition.

### 2.2 `D-2` — `P2-C`: normalization **policy** (closes the policy limb only)

Policy: **STRIP-WITH-EXCEPTIONS**. Counting unit: **grapheme cluster**.

Supporting external material: **UAX #31**, Unicode **17.0.0**, revision **43**, 2025-08-20 — §2.3
(*"A profile should be used to remove them … unless their use is required in a particular domain"*;
*"Default_Ignorable_Code_Points should be ignored for comparison"*) and §7.3 (*Default-Ignorable
Exclusion Profile*).

⚠⚠ **The limitation is recorded as part of the decision, not omitted from it.** UAX #31 governs
**programming-language identifier syntax**, not natural-language search. It establishes that
strip-with-exceptions is a **recognised Unicode profile shape**; it does **NOT** establish Liboora's
natural-language search rule, and this ADR **does not claim that it does**.

⛔ Therefore the **exact `ZWJ`/`ZWNJ` exception set** and the **`N6` × `N4` application order** remain
**OPEN**, exactly as `ADR-0099` **L110** requires — *"evidence-bound to the applicable Unicode/product
authority."* ⛔ **No exception is invented here.**

### 2.3 `D-3` — `P3`: typo tolerance (closes `SRCH-BR-012` C2 and C3)

| Parameter | Value |
|---|---|
| Maximum edit distance | **1** |
| Minimum token length for tolerance | **3 grapheme clusters** |

Constraints preserved unchanged: `C1` no tolerance on exact-role fields (`SRCH-FR-027`) · `C3` the bound
is **uniform across consumers** (`SRCH-FR-009`, `SRCH-FR-034`) · `C4` a T3 typo match **MUST NOT**
outrank any T1 or T2 match · `C5` typo matching **MUST NOT** widen authorisation, tenant scope or field
eligibility.

⭐ `SRCH-BR-012` **L574** named the Architecture Owner as the owner of C2's minimum length and C3's
bound. **This act is that owner supplying them.**

### 2.4 `D-4` — `P4`: prefix matching (closes `SRCH-FR-030`'s open bound)

Minimum prefix length = **3 grapheme clusters**. `Lib` → `Library` matches; a two-grapheme prefix does
not trigger prefix matching. Multi-word search remains **conjunctive and order-independent**, unchanged.

⚠ `SRCH-FR-030`'s own `Lib` → `Library` illustration is **consistent** with 3 but did **not** establish
it — *an example is not a bound*. The value is this act's decision, not a repository discovery.

### 2.5 `D-5` — `P8-B`: stale-serving posture

| Path | Rule |
|---|---|
| Ordinary index freshness / removal | **≤ 60 seconds** |
| ⭐ Revoked · private · no-longer-entitled | **0 — FAIL CLOSED IMMEDIATELY.** No propagation allowance whatsoever |

⛔⛔ **The 60-second value MUST NOT become an authorization cache, an entitlement TTL, or a grace period
on any authorization path.** `BC-23` **MUST** ask `BC-18` per request, **MUST NOT** evaluate entitlement
locally, and **MUST NOT** cache entitlement truth.

⭐ **The stricter pre-existing rule governs and is preserved, not overwritten:** `SRCH-FR-013` /
`SEV-9` require a privacy-mode change to apply with **no propagation window**, §31 forbids `BC-23` from
defining any eventual-consistency allowance for it, and Rank 1 **`MP-GBR-26`** makes revocation
*"immediate and global — authoritative-or-absent, with no propagation window."*

⚠ **Two available false equivalences are expressly refused.** `LCFG-6` is also 60 s but is *"Removal
latency only"* and *"must never be consulted on an authorization path"*; `LCFG-13` is 300 s but
*"Never applies to an authorization decision."* Neither sources this decision.

### 2.6 `D-6` — `P8-D`: rebuild-mode selection rule

| Mode | Triggers — closed list |
|---|---|
| **INCREMENTAL** | ordinary additions · ordinary updates · ordinary removals · routine refresh |
| **FULL** | index corruption · unrecoverable generation inconsistency · schema/mapping incompatibility · analyzer/tokenization configuration change invalidating existing index contents · explicit migration requiring complete regeneration |

⛔ **No further trigger is added.** §34's constraints are preserved: a rebuilt index **MUST** be
equivalent to the projection it replaces, and **MUST NOT** re-admit documents that were removed.

---

## 3. What this act does **NOT** decide — and why

### 3.1 ⭐⭐⭐ `P1` — the **transport-binding limb** is OPEN, and the instruction did not address it

The **engine limb** closes: architecture remains **vendor-neutral**, engine selection is a
**deployment decision**, and this is `MP-CON-02` verbatim — *"Choosing a BaaS for V1 is a **deployment
decision, not an architecture decision**."* ✅ Compatible.

⚠⚠ **But `P1` has a second limb the conferring instruction never mentioned.** `PRD-015` **§42 L980**
enumerates `SRCH-GAP-002` as *"… rebuild posture, **transport binding**"*, and **§37 L891** states
verbatim:

> *"⛔ **No wire format, protocol, endpoint path, field naming convention or serialisation is stated.**
> … no authority grants `PRD-015` the platform's API-convention decision. **Transport binding is
> `SRCH-GAP-002` (P1), owner Architecture Owner.**"*

⛔ **This act does not decide it.** The instruction supplied no transport decision, and §7 of the
instruction forbids inventing *"additional APIs."* Deciding a platform-wide API convention inside a
`BC-23` ADR would also make one module's ADR bind twenty-five other contexts.
→ **`P1` transport binding: OPEN. Owner: Architecture Owner, as a platform API-convention act.**

### 3.2 ⭐⭐⭐ `P7` availability — the Architecture Owner is **not** the owner

**Rank 1 `MP-NFR-01`** (`MASTER_PRD.md` **L495**) assigns *"Availability — per-function availability
targets with SLOs, SLIs and error budgets"* to owner **SRE / OBSERVABILITY**.

The Architecture Owner is a **different office**. `ADR-0054` **L148**, on two adjacent governance
roles, holds *"Those are different roles."* An Architecture Owner act cannot confer a value a Rank 1
table assigns elsewhere.

⭐ The **value itself is validated and pre-approved for that owner**: `99.9% monthly` is an existing
repository convention — `authentication/prd-v2/11-NFR-Compliance-and-Final-Acceptance.md` **L67**
(*"Authentication service availability | 99.9% monthly"*), **L68**/**L69** at 99.95%. ⭐ **Coherence
check:** `BC-18`'s authorization-decision availability is **99.95%**, so a dependent search service at
**99.9%** sits *below* its dependency — the correct direction. Had the proposal been 99.99%, this ADR
would have had to report a defect.
→ **`P7` availability: OPEN. Owner: SRE / OBSERVABILITY. Value pre-approved, awaiting the right office.**

### 3.3 ⭐⭐⭐ `P7` latency — decided as a **component** target, with a disclosed missing destination

⭐⭐ **`LIB-20.1` is narrower than it first appears, and the difference is measured, not asserted.**
`Library_PRD_v1.md` **L862-864** (FROZEN, Rank 3) reads: *"**Platform-wide** NFR budgets **MUST** be
taken from the Enterprise Architecture NFR Budgets document. **This PRD** **MUST NOT** state a competing
latency or availability figure."* Its prohibition binds *"**This PRD**"* — the **Library** PRD — and its
sourcing rule is scoped to *"**platform-wide**"* budgets. A `BC-23` **component** latency target is
neither.

⭐ **The precedent confirms the narrower reading:** `Authentication_PRD_v2` §11.3 carries
component-level NFR figures (three availability targets and *"Maximum tolerable continuous outage |
30 minutes"*) inside a module PRD. Component NFRs demonstrably live at module level in this repository.

Accordingly, **as a `BC-23` component target**: normal target **≤ 2 s**, hard upper bound **≤ 5 s**.
⛔ Not a vendor SLA. ⛔ Not stated inside `PRD-015`, whose §36 refusal is left intact.

⚠⚠ **But the destination artifact does not exist, and that is disclosed rather than glossed.**
`find docs/ -iname "*NFR*" -o -iname "*budget*"` returns **exactly one** file — Authentication's own
chapter. There is **no** Enterprise Architecture NFR Budgets document. EA **L339-344** carries
`NFR Budgets (V1)` as **headings with zero values**, and `DOCUMENTATION_BASELINE.md` **L191** lists
*"NFR Budgets"* among `PRD-023`'s **five hard-external blockers**.
→ **`P7` latency: component target DECIDED; platform reconciliation OPEN** until that document is
commissioned. ⛔ The EA is **NOT** edited — `ADR-0079` holds that the EA *"records a determination made
at Rank 1 — it does not make one"*, so writing a first-instance budget into a Rank 6 descriptive
artefact would invert the rank order.

### 3.4 `P7` throughput — non-numeric by instruction

Recorded qualitatively: *"the V1 workload must be supported without violating the approved latency
budget."* ⛔ **No QPS figure is invented.** The numeric limb is **OPEN by express instruction**.

### 3.5 `P8-C` rebuild duration — target recorded, verifiability OPEN

Operational **target**: full rebuild **≤ 30 minutes** for the V1 operational corpus. ⛔ Not a guarantee
for unbounded corpus size. ⛔ **No corpus size is invented.**

⚠ **Self-adverse disclosure:** because the *"V1 operational corpus"* is nowhere defined, this target is
**currently unverifiable** — no test can pass or fail it. A target that cannot be measured is recorded
as a target and **not** counted as a closed parameter.
→ **`P8-C`: target DECIDED; verifiability OPEN pending a corpus definition.**

### 3.6 Vocabulary and field-level script values — no authority exists

⛔ **Vocabulary content: OPEN.** A search of `docs/30-product/` (excluding `PRD-015`) returns **zero**
authoritative Product Owner synonym, abbreviation, alias, transliteration or Hinglish sources. `V4`
stays narrow per `PRD-015` L551-553. ⛔ Nothing is invented to close `SRCH-GAP-007`.

⛔ **Field-level script values: OPEN.** §14A declares **zero** scripts (grep for `declared script|script:`
→ **0** hits; `F5_CLASSIFICATION_DECISION_PACKET.md` **L175**: *"Zero of the seven owning contexts
declares a script."*) ⛔ §14A is **FROZEN and NOT modified**. ⛔ Script is **NOT** inferred from field
names — the instruction forbids it and `SRCHAO-F5` Option A forbids inference generally. ⛔ Ownership is
**NOT** transferred to `BC-23`. The per-field declaration is a **Product Owner** act by the owning
context, on an unfrozen locus.

### 3.7 Language scope and Hinglish — closed

✅ Canonical V1 inventory: **English + Hindi**, a closed set of two (`SRCHPO-1`, `HD-16`, `ADR-0099`
`C-8`). English → **Latin**, Hindi → **Devanagari**, *where applicable*.
✅ **Hinglish / Romanized Hindi** is a **supported query behaviour where technically validated** — ⛔ not
a third canonical language, ⛔ not a third index, ⛔ not a new bounded context, ⛔ not automatic
vocabulary expansion.
✅ ⛔ **Device locale MUST NOT expand the V1 language inventory.** This is a genuine addition: `LCFG-2`
(`CONFIGURATION_GUIDE.md` **L352**) carries Range *"Supported set"* — open-ended — and a Rank 7
configuration value must not enlarge a closed architectural inventory.

---

## 4. Security — verified, not assumed

| # | Requirement | Result | Authority |
|---|---|---|---|
| 1 | `BC-18` remains sole entitlement authority | ✅ | BC Map **L127**; Matrix **L220** |
| 2 | `BC-23` never grants access | ✅ | §33 *"the index never grants access"* |
| 3 | `BC-23` never evaluates entitlement | ✅ | Matrix **L220** *"ask BC-18, never evaluate or cache"* |
| 4 | `BC-23` never caches entitlement truth | ✅ | `MP-GBR-26`; `§2.5 D-5` above |
| 5 | Revoked/private fails closed immediately | ✅ | `SRCH-FR-013`, `SEV-9`, §35 *"Fail closed"* |
| 6 | 60 s freshness is not an authorization window | ✅ | `§2.5 D-5` carve-out; `LCFG-6` L377-380 |
| 7 | Tenant isolation enforced | ✅ | `SE-1`, `X-13`, `SRCH-INV-002`, `AR-3` |
| 8 | Typo/prefix matching cannot bypass authorization | ✅ | `SRCH-BR-012` `C5`, preserved verbatim in `D-3` |
| 9 | Normalization cannot alter authorization identity | ✅ | `SRCH-FR-005` — authorization identity is the **owning aggregate identifier**, not a normalized term |
| 10 | Ranking cannot override source authorization | ✅ | `SRCH-FR-040`, `SRCH-FR-042`, §27 |

⚠ **One residual risk is disclosed rather than absorbed.** UAX #31 §7.3 notes that excluding
default-ignorable code points *"does not prevent spoofing issues."* Normalization therefore does not
breach **authorization** (check 9 holds on `SRCH-FR-005`), but it may affect **discoverability and
impersonation** in displayed results. ⛔ That is **not** decided here; it is routed to the
`SRCH-GAP-004` owners (Architecture Owner analyzer + Product Owner acceptable use).

---

## 5. Integrity

| Item | State |
|---|---|
| `PRD-015_SEARCH_INDEXING.md` | ⛔ **byte-unchanged** — `fe3093e6…c2c4544` |
| `Library_PRD_v1.md` incl. **§14A** (FROZEN) | ⛔ **NOT MODIFIED** |
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md` (Rank 6) | ⛔ **NOT MODIFIED** |
| `MASTER_PRD.md`, BC Map, Dependency Matrix, `DOCUMENTATION_BASELINE.md` | ⛔ **NOT MODIFIED** |
| `ADR-0099` and every other `Accepted` ADR | ⛔ **NOT superseded, NOT restatused, bytes unchanged** |
| `tool/module_dependencies.yaml` and all validators | ⛔ **NOT MODIFIED** — Gate 3 inputs byte-identical; ⛔ Gate 3 **NOT** claimed rerun |
| Application code | ⛔ **0 lines.** `lib/`, `test/`, `android/`, `web/`, `pubspec.yaml` untouched |
| `IMPL-*` identifiers | ⛔ **0 created** |
| New bounded contexts / edges / events / APIs | ⛔ **0** |
| Lifecycle | ⛔ **Stage 3 NOT conferred.** `PRD-015` remains Stage 2 `DRAFT`, registry `PLANNED`. Stages 4, 5, 6, 7 **NOT entered** |

⛔ **`SRCH-GAP-002` and `SRCH-GAP-007` both remain OPEN.** Six limbs close; **seven** do not. This ADR
is a partial discharge and says so in its own title.
