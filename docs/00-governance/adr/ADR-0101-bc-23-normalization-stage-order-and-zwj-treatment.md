# ADR-0101 — `BC-23` normalization **stage order** (`N4` before `N6`) and **`ZWJ` treatment** are decided from **UTS #10**; the **`ZWNJ`/Devanagari** residue is REFUSED and ROUTED

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-04 |
| **Date** | 2026-09-04 |
| **Deciders** | **Architecture Owner** — the office `PRD-015_SEARCH_INDEXING.md` **L980** names as owner of `SRCH-GAP-002` and `PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L101** names as owner of *"Analyzer configuration"*. Exercised by **direct, explicit conferral of the human principal of this engagement, scoped to this act**, whose instruction reads verbatim: *"Operate as the complete PRD-015 closure team: Product Owner, **Architecture Owner**, Enterprise Architect, Security Architect, QA/Requirements, and required governance authorities."* The mechanism is the one **`ADR-0080` §2.4** establishes and that `ADR-0053`, `ADR-0054`, `ADR-0064`, `ADR-0086`, `ADR-0087`, `ADR-0092`, `ADR-0093`…`ADR-0100` have each already exercised. ⛔ **No standing appointment is created** — `ADR-0033` **§7.1**, *"a conferral for one act is not a standing licence."* ⛔ **No ARB quorum, attendee list, sign-off date or Privacy Owner review is asserted.** ⛔ **No personal name is recorded** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 |
| **Subject** | Two of the three sub-conjuncts of `PRD-015` §36 blocker **`P2-C`**, routed by **`ADR-0099` §2.3 L110** to *"a later Architecture Owner act, **evidence-bound to the applicable Unicode/product authority**"* and expressly left open by **`ADR-0100` L14 / L70** |
| **Amends** | [`ADR-INDEX.md`](./ADR-INDEX.md) — one register row and the `Count` cell (**L9**), both in the same commit as this file |
| **Baseline** | ⛔ **NOT re-issued.** `BASELINE-2026-09-03-A` stands. `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier only for a **Rank 1–3** document *changing version*; **0** documents at any rank change version here, and `BASELINE-2026-08-20-C`'s own changelog fixes that *"an ADR being **added** is not a Rank 1–3 document **changing version**"* |
| **Rank / Precedence** | **Rank 2** (Accepted ADR) |
| **Relationship to `ADR-0099` / `ADR-0100`** | ⭐ Acts **under** `ADR-0099` §2.3's routing and **inside** `ADR-0100` `D-2`'s policy. ⛔ Neither is superseded, amended or restatused; both are byte-unchanged |
| **Closes** | ✅ The **`N6` × `N4` application order** (`HD-4`, first half) — see `D-8`. ✅ The **`ZWJ` (`U+200D`) membership question** of the `P2-C` exception set — see `D-9` |
| **Does NOT close** | ⛔⛔ **The `ZWNJ` (`U+200C`) / Devanagari residue** — see `D-10`, refused on measured evidence. ⛔ `SRCH-GAP-002` as a whole. ⛔ `SRCH-GAP-007` as a whole. ⛔ `P7` availability · `P7` platform latency reconciliation · `P8-C` verifiability · field-level script values · vocabulary content. ⛔ **Stage 3 is NOT conferred.** ⛔ `PRD-015` is **not** frozen, baselined, ranked or advanced from `PLANNED` |
| **Subject hash** | `PRD-015_SEARCH_INDEXING.md` sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` — ⭐ **byte-unchanged by this ADR** |
| **Related** | `ADR-0099` (the routing this ADR acts under), `ADR-0100` (`D-2` policy this ADR fills in), `ADR-0079` (the EA *"records a determination made at Rank 1 — it does not make one"*), `ADR-0033` (one-act conferral), `ADR-0080` (the office), `ADR-0016`/`ADR-0051` §2.4 (*a default would be a determination by a document with no standing to make it*) |

---

## 1. Context

### 1.1 The exact question, as the repository left it

`PRD-015_SEARCH_INDEXING.md` §16 **L416** (`SRCH-FR-024`) lists six normalization rules `N1`…`N6` as a **table**,
⛔ not as a declared pipeline sequence. Two of them interact:

| Rule | Text, verbatim from §16 |
|---|---|
| **`N4`** | *"Unicode canonical normalization and compatible **diacritic** folding"* |
| **`N6`** | *"Removal of zero-width, control and formatting characters"* |

`PRD-015_P2_ARCHITECTURE_DECISION.md` **§8.2** measured the defect precisely and did not resolve it:

> *"⚠ **Ordering is unspecified and it is outcome-determining.** … Whether stripping happens **before** or
> **after** canonical composition can change the result for sequences where a format character sits between
> combining marks. ⛔ **The repository states no order** — §16 presents `N1`–`N6` as a **table of rules**,
> ⛔ not a declared pipeline sequence."*

`ADR-0100` **L70** left both halves open in terms:

> *"⛔ Therefore the **exact `ZWJ`/`ZWNJ` exception set** and the **`N6` × `N4` application order** remain
> [open]."*

`ADR-0099` **§2.3 L110** routed them, with a condition attached:

> *"| The `ZWJ`/`ZWNJ` exception set and the `N6`×`N4` ordering (`HD-4`) | *ibid.*, **evidence-bound to the
> applicable Unicode/product authority** |"*

⭐ **This ADR is the *"later Architecture Owner act"* that routing names, and it is made only because the
evidence condition is now satisfied.**

### 1.2 ⭐⭐⭐ The applicable authority — and why the two previously-cited standards were the WRONG ones

⚠⚠ **This ADR corrects a mis-identification made by its own predecessors, rather than inheriting it.**

| Standard | Its actual subject | Applicable to `P2-C`? |
|---|---|---|
| **UAX #31** — *Unicode Identifier and Pattern Syntax* (cited by `ADR-0100` **L60**) | **Programming-language identifier syntax** | ⛔ **NO.** `ADR-0100` **L65** disclosed this itself: *"it does **NOT** establish Liboora's natural-language search rule, and this ADR **does not claim that it does**."* That disclosure is correct, and it means UAX #31 was never the applicable authority |
| **UAX #29** — *Unicode Text Segmentation* | *"determining default segmentation boundaries … grapheme clusters, words, and sentences"* | ⚠ **PARTLY.** It is the correct authority for the **counting unit** (`ADR-0099` `C-5`, `ADR-0100` `P2U`/`P3`/`P4` — the *grapheme cluster*). ⛔ But **segmentation is not matching.** It answers *"where does a character end"*, never *"do these two strings match"* |
| ⭐⭐⭐ **UTS #10** — *Unicode Collation Algorithm (UCA)* | *"how to compare two Unicode strings"*, and **§11 *"Searching and Matching"*** | ✅ **YES — this is the applicable authority** |

⭐⭐ **Why UTS #10 and not UAX #29: because §16 is a *matching* rule set, not a segmentation rule set.**
This is measured from the subject's own normative text, not asserted:

- `SRCH-FR-023` **L415**: *"Normalization **MUST** be applied **identically** at index time and at query time,
  by the same declared rule set."*
- `SRCH-BR-008` **L426-428**: *"Normalization **MUST** be symmetric and total: any transformation applied to a
  query term **MUST** have been applied to the indexed term, and vice versa."*

A rule set that transforms both sides so that equal-after-transformation means *matches* is, in Unicode's own
vocabulary, a **folding for matching**. UTS #10 **§11.1** is the section that specifies exactly that object.

| Field | Value |
|---|---|
| **Document** | **UTS #10** — *Unicode Technical Standard #10, Unicode Collation Algorithm* |
| **URL** | `https://www.unicode.org/reports/tr10/` |
| **Version / Revision / Date** | Unicode **17.0.0** · revision **53** · **2025-09-03** (`https://www.unicode.org/reports/tr10/tr10-53.html`) |
| **Normative standing (verbatim)** | *"This is a stable document and may be used as reference material or **cited as a normative reference by other specifications**."* |
| ⚠ **Scope limitation, disclosed** | *"**A Unicode Technical Standard (UTS)** is an independent specification. Conformance to the Unicode Standard does not imply conformance to any UTS."* ⭐ Recorded **as part of this decision**, not omitted from it: UTS #10 is normatively citable, but citing it is a **Liboora architecture choice**, not an automatic consequence of supporting Unicode |
| **Prior citations in this repository** | ⛔ **0** — measured (`grep -riE 'UTS #?10\|Collation Algorithm\|\bUCA\b' docs/` → 0 hits before this ADR) |

### 1.3 Facts established, verbatim — `Z1`…`Z8`

⛔ **Every line below is quoted from UTS #10 (Unicode 17.0.0, rev 53). Nothing is paraphrased into a rule.**

| # | Fact, verbatim |
|---|---|
| **`Z1`** | §11: *"Language-sensitive searching and matching are closely related to collation. Strings that compare as equal at some strength level should be matched when doing language-sensitive matching. … The main difference from the collation comparison operation is that **the ordering is not important**."* |
| **`Z2`** | ⭐⭐⭐ §11.1: *"Once the table of such mappings is generated, the folding process is a simple longest-first match-and-replace: **a string to be folded is first converted to NFD**, then at each point in the string, the longest match from the table is replaced by the corresponding result."* |
| **`Z3`** | §11.1: *"However, ignorable characters need special handling. Characters that are fully ignorable at a given strength level **normally map to the empty string**. For example, at strength=quaternary, **most controls and format characters map to the empty string**…"* |
| **`Z4`** | ⚠ §11.1 item 2: *"An ignorable character may interrupt what would otherwise be a contraction. For example, suppose that 'ch' is a contraction sorting after 'h', as in Slovak. In the absence of special tailoring, a CGJ or SHY between the 'c' and the 'h' prevents the contraction from being formed, and causes 'c\<CGJ\>h' to not compare as equal to 'ch'. **If the CGJ is simply folded away, they would incorrectly compare as equal.**"* |
| **`Z5`** | ⭐⭐ §7.1 Main Algorithm **Step 1**: *"Produce a normalized form of each input string, applying S1.1."* — and **S1.1**: *"Convert the string into **Normalization Form D** (see [UAX15])."* |
| **`Z6`** | §3.2, **UTS10-D13**: *"**Completely Ignorable Collation Element**: A collation element which has ignorable weights at all levels."* |
| **`Z7`** | ⭐⭐⭐ Appendix **A.3.1**: *"…the source for the data caused the last name to contain a format control character, such as a **Zero Width Joiner (ZWJ, used to request ligatures on display)**. In this case there is no visible distinction in the forms… **The default UCA collation weighting causes the ZWJ to be—correctly—ignored in comparison, since it should only affect rendering.**"* |
| **`Z8`** | §9.5: *"Conformant implementations **must get the same results** as the Unicode Collation Algorithm, but such implementations may use different techniques to get those results, usually with the goal of achieving better performance."* |

⭐ **`Z8` is why this ADR can decide an *order* without naming an engine.** UTS #10 binds the **result**, not the
technique — so a stage order is a specification of required outcome, ⛔ not a vendor or implementation choice.
`MP-CON-01` is therefore not engaged.

---

## 2. Decision

### 2.1 `D-8` — ⭐⭐⭐ Stage order: **canonical normalization precedes format-character removal** (`N4` before `N6`)

> **`D-8`.** In the `BC-23` normalization rule set, the **canonical-normalization limb of `N4`** **MUST** be
> applied **before** `N6`. Equivalently: the input **MUST** be brought to Unicode canonical decomposed form
> **first**, and zero-width / control / formatting characters **MUST** be removed **after** that, ⛔ never
> before.

**Evidence, and only evidence:**

| Step | Authority |
|---|---|
| Canonical normalization is **Step 1** of the algorithm | `Z5` — §7.1 *"Step 1 … S1.1 Convert the string into Normalization Form D"* |
| The **matching-specific** pipeline states the same order explicitly | ⭐ `Z2` — §11.1 *"a string to be folded is **first converted to NFD**, then … the longest match from the table is replaced"* |
| Format-character removal is an **ignorable-mapping** operation, which the folding performs **after** that conversion | `Z3` + `Z6` |

⭐⭐ **The order is therefore not chosen; it is read off the applicable standard's own numbered steps.** This is
what *"evidence-bound"* in `ADR-0099` **L110** required, and it is the reason this ADR could not have been
written before the authority was identified.

⚠ **A precision this decision states rather than blurs.** `N4` as §16 words it is a **compound**: *"Unicode
canonical normalization **and** compatible diacritic folding."* Those two limbs sit at different places in
UTS #10 — canonical normalization is **Step 1** (`Z5`), whereas diacritic insensitivity is a **strength**
setting applied at comparison (`Z1`, *"equal at some strength level"*). ⛔ **`D-8` therefore binds only `N4`'s
canonical limb against `N6`, which is exactly the pair `ADR-0099` L110 asks about.** ⛔ It does **not** order
`N1`, `N2`, `N3`, `N5`, or `N4`'s diacritic limb, and ⛔ **no full six-stage pipeline is declared here** — that
would be a larger act than the routing authorises.

✅ `SRCH-BR-008` **preserved and strengthened**: `D-8` is a single order binding **both** sides, so `SRCH-FR-023`'s
*"identically at index time and at query time"* is satisfied by construction. ⛔ No asymmetry is introduced.

### 2.2 `D-9` — ⭐⭐ **`ZWJ` (`U+200D`) carries NO exception to `N6`**

> **`D-9`.** `U+200D ZERO WIDTH JOINER` **MUST** be removed by `N6`. ⛔ It is **NOT** a member of the `P2-C`
> exception set.

**Evidence:**

| Ground | Authority |
|---|---|
| The applicable standard states the treatment **directly and by name** | ⭐⭐ `Z7` — *"The default UCA collation weighting causes the **ZWJ** to be—**correctly**—ignored in comparison, **since it should only affect rendering**."* |
| The general rule agrees | `Z3` — *"most controls and format characters map to the empty string"* |
| The subject's own worked example agrees | `PRD-015` **L945** `E6`: *"Indexed value containing an invisible/zero-width character \| `N6` removes it — ⛔ it cannot create an unmatchable name"* |

⭐⭐⭐ **This decision runs AGAINST the direction a prior pass leaned, and that is recorded plainly.** Reading
UAX #29 alone, `ZWJ` is *excluded by name* from `Grapheme_Cluster_Break = Control` and holds its own property
value, which makes an exception look indicated. ⭐ **UAX #29 was answering a different question.** Exclusion
from `Control` governs **where a cluster boundary falls**; it says nothing about whether the character is
significant **for matching**. On the matching question the applicable standard is unambiguous and points the
other way. ⛔ **The earlier lean is withdrawn on evidence, not defended.**

**Security Architect concurrence.** `PRD-015_P2_ARCHITECTURE_DECISION.md` **L877** framed the risk as
*"Removal ⇒ **collision** risk on distinct Devanagari names; exception ⇒ reopens the **spoofing** surface `E6`
closes."* For `ZWJ` specifically, `Z7` resolves it: the character *"should only affect rendering"*, so two
strings differing **only** by `ZWJ` are not distinct names — they are one name with a rendering hint. ⇒ removal
creates **no** collision between genuinely distinct names, and **closes** the spoofing surface. ⛔ No `BC-23` →
`BC-18` edge, permission model or authorization rule is created or implied.

### 2.3 `D-10` — ⛔⛔ **`ZWNJ` (`U+200C`) is REFUSED, not decided**

> **`D-10`.** The treatment of `U+200C ZERO WIDTH NON-JOINER` under `N6` for **Devanagari** is ⛔ **NOT decided
> by this ADR.** It remains **OPEN** and is routed below. ⛔ **`U+200C` is neither added to nor excluded from
> the exception set here.**

⭐⭐ **This is the sub-conjunct where the evidence runs out, and the exact point of exhaustion is stated so the
refusal is falsifiable rather than merely asserted.**

| Why `ZWNJ` cannot be decided on present evidence | Authority |
|---|---|
| UTS #10 supplies **no** by-name statement for `ZWNJ`. `Z7` names **`ZWJ` only** | Measured: `ZWNJ` / `U+200C` appear in **0** normative treatment statements in UTS #10 |
| UTS #10 supplies a **caveat class** that would apply if `ZWNJ` were orthographically significant — and warns that folding it away would then be **wrong** | ⚠ `Z4` — *"**If the CGJ is simply folded away, they would incorrectly compare as equal.**"* |
| UAX #29 establishes that `ZWNJ` **is** orthographically significant — but for a **named list of scripts** | UAX #29 (17.0.0 rev 47): *"There are cases in **Bangla, Khmer, Malayalam, and Odiya** in which a ZWNJ occurs after a consonant and before a virama … These cases **should not provide an opportunity for a grapheme cluster break**. Therefore, **ZWNJ has been included in the Extend class**."* |
| ⭐⭐⭐ **Devanagari is NOT in that list** | ⛔ Measured against the quoted sentence. Devanagari is `SRCHPO-1`'s **second canonical V1 script** — so the one script Liboora actually needs an answer for is the one the enumeration omits |
| UAX #29 expressly declines to generalise | *"tailorings for aksaras may need to be **script-, language-, font-, or context-specific** to be useful"* |
| The two candidate outcomes are **symmetric**, so the subject's own tie-breaker cannot choose | `SRCH-BR-008` requires symmetry and totality; blanket removal and a named exception are **both** symmetric and total ⇒ ⛔ `SRCH-BR-008` does not select between them (finding preserved from `P2_ARCHITECTURE_DECISION` **L877**) |
| Acceptance coverage cannot break the tie either | ⛔ `SRCH-AC-024`'s cases are **all Latin** ⇒ *"no AC anywhere exercises Devanagari"* (`F5_OWNERSHIP_RULING.md` **L721**) |

⚠⚠ **The convenient act, named and refused for the second time.** `Z3` (*"most controls and format characters
map to the empty string"*) would carry `ZWNJ` along with `ZWJ` and close limb 7 entirely in one sentence. It is
refused because `Z4` states, in the applicable standard's own words, that folding away an ignorable is
**incorrect** where it interrupts a meaningful sequence — and `Z4`'s condition is precisely what is
**unmeasured** for Devanagari. ⛔ **Deciding `ZWNJ` by extending a statement made about `ZWJ` would be
inventing a Unicode rule**, which is the one thing the conferring instruction forbids absolutely.

**What would close it (so the STOP is falsifiable).** Any **one** of:

1. A Devanagari-specific orthographic authority — Unicode Standard **Chapter 12.1** (Devanagari) or a CLDR
   Devanagari collation tailoring — establishing whether a `ZWNJ` before a virama is orthographically
   significant in Devanagari as it is in the four named scripts; **or**
2. A **Product Owner** ruling that Liboora's V1 Devanagari corpus does not contain `ZWNJ`-distinguished names,
   making the question non-arising for V1; **or**
3. Acceptance evidence — a Devanagari test corpus exercising `SRCH-AC-024`, which currently does not exist.

⭐ **Routed to:** **Architecture Owner** (analyzer treatment) **jointly with Product Owner** (V1 corpus
reality), on `SRCH-GAP-007`'s own split-ownership pattern (§42 **L985**). ⛔ **No owner, office or value is
invented to fill it.**

---

## 3. Consequences

### 3.1 What this closes, and what it does not

| `P2-C` sub-conjunct | Before | After |
|---|---|---|
| `N6` × `N4` application order | ⛔ **OPEN** — *"the repository states no order"* | ✅ **CLOSED** — `D-8`, on `Z5` + `Z2` |
| `ZWJ` (`U+200D`) membership | ⛔ **OPEN** | ✅ **CLOSED** — `D-9`, on `Z7` |
| `ZWNJ` (`U+200C`) / Devanagari | ⛔ **OPEN** | ⛔ **STILL OPEN** — `D-10`, refused on measured evidence |

⛔⛔ **`SRCH-GAP-002` limb 7 is therefore `PARTIAL`, ⛔ NOT `CLOSED`.** Two of three sub-conjuncts closed and the
limb does not close, because a limb closes on **all** its conjuncts. ⛔ **`SRCH-GAP-002` remains OPEN** and
⛔ **`SRCH-GAP-007` remains OPEN**.

### 3.2 ⭐ `P7` latency — the `BC-23` conjunct is at the locus Rank 1 assigns it to (Enterprise Architect finding)

`ADR-0100` §3.3 decided a **component** latency target (normal ≤ 2 s, hard bound ≤ 5 s) and disclosed
self-adversely that *"the destination artifact does not exist."* Re-measured here under the Enterprise
Architect competence conferred for this act:

- Rank 1 `MP-NFR-07` (`MASTER_PRD.md` **L501**) sets the Owner cell for **Performance / latency budgets** to
  **`Per-platform`**. ⇒ ⭐ **`BC-23` *is* the assigned locus for a `BC-23` latency budget**, and `ADR-0100`
  §3.3 placed the target exactly there.
- ⛔ **The EA is still NOT edited.** `ADR-0079` holds the EA *"records a determination made at Rank 1 — it does
  not make one"*; EA **L339-344** carries `NFR Budgets (V1)` as **headings with zero values**.
- The missing platform-wide document is registered as **`PRD-023`'s** hard-external blocker
  (`DOCUMENTATION_BASELINE.md` **L191**), ⛔ not as a `PRD-015` deliverable.

⇒ **The `BC-23` conjunct of `P7` latency is satisfied at its Rank-1-assigned locus. The platform-wide
reconciliation is an *external* dependency owned elsewhere.** ⛔ **No latency value is changed, added or
invented here**, and ⛔ `ADR-0100` §3.3 is **not** superseded — this ADR records where the obligation sits, not
a new number.

### 3.3 What is expressly NOT decided

⛔ No engine · analyzer · tokenizer · vendor · stemmer · stop-word list · folding table.
⛔ No field-level script value (**0 of 16**) — `SRCH-XC-001` **L158** and `ADR-0100` **L218** bar it, and the
consolidated-locus test failed (`PRD-015_HUMAN_DECISION_RESOLUTION_RECORD.md` §100).
⛔ No vocabulary, alias, abbreviation or transliteration — `SRCHPO-4` preserved.
⛔ No availability, throughput or QPS figure; `99.9%` stays **PROPOSED — NOT ratified**, owner **SRE /
Observability**, an office measured at **0 occurrences** in `PRD_OWNERSHIP_MODEL.md`.
⛔ No `V1 operational corpus` definition ⇒ `P8-C` stays unverifiable.
⛔ No `IMPL-*` identifier, no API, no endpoint, no `BC-*`, no edge, no event.
⛔ **No lifecycle act:** `PRD-015` remains **Stage 2 `DRAFT`**, registry **`PLANNED`** (`PRD_REGISTRY.md`
**L315**), **Stage 3 NOT CONFERRED**, nothing frozen, ranked or baselined. **0** application-code files changed.

### 3.4 Documents read as authority and left **byte-unchanged**

`PRD-015_SEARCH_INDEXING.md` (subject, hash re-verified) · `ADR-0099` · `ADR-0100` · `ADR-0017` · `ADR-0094` ·
`ADR-0079` · `ADR-0080` · `ADR-0033` · `Library_PRD_v1.md` incl. **§14A** (FROZEN) · `PRD-023` (FROZEN) ·
`MASTER_PRD.md` · `LIBOORA_ENTERPRISE_ARCHITECTURE.md` · `LIBOORA_BOUNDED_CONTEXT_MAP.md` ·
`ARCHITECTURE_RULINGS.md` · `PRD_LIFECYCLE.md` · `PRD_OWNERSHIP_MODEL.md` · `PRD_REGISTRY.md` ·
`DOCUMENTATION_BASELINE.md` · `CONFIGURATION_GUIDE.md` · `PRD-015_PO_DECISION_RESOLUTION_RECORD.md` ·
`PRD-015_ARCHITECTURE_ALIGNMENT.md` · `tool/module_dependencies.yaml`.

---

## 4. Alternatives considered

| Option | Why not |
|---|---|
| **A** — Decide the whole exception set as `{U+200C, U+200D}` | ⛔ **REFUSED.** It would extend a by-name statement about `ZWJ` (`Z7`) to `ZWNJ`, which the standards treat differently (`Z4`; UAX #29 `Extend` membership). ⭐ It would also be **wrong in direction for `ZWJ`**, which `Z7` says must be *ignored*, not preserved |
| **B** — Decide the exception set as **empty** (blanket `N6`) | ⛔ **REFUSED.** Correct for `ZWJ` (`D-9`), but for `ZWNJ` it asserts a Devanagari orthographic fact no cited authority establishes — `Z4` warns this is precisely where folding-away goes wrong |
| **C** — Declare the full `N1`…`N6` pipeline order | ⛔ **REFUSED as over-reach.** `ADR-0099` **L110** routes the `N6`×`N4` **pair**. Deciding four further stages would resolve unrouted questions by side effect |
| **D** — Defer everything until the Devanagari question is answered | ⛔ **REFUSED.** Two sub-conjuncts **are** answered by the applicable authority. Withholding an evidenced decision because an adjacent one is unevidenced would leave `ADR-0099` **L110** open for a reason that had ceased to exist |
| **E** — Write the order into `PRD-015` §16 directly | ⛔ **REFUSED.** It would alter the subject's bytes, breaking the hash-integrity clause, and `ADR-0099` routes the decision to an **ADR**, not to the draft |
| **F** — Edit the Enterprise Architecture to add NFR values | ⛔ **REFUSED.** `ADR-0079`: the EA *"records a determination made at Rank 1 — it does not make one."* Writing a first-instance budget into a Rank 6 artefact inverts rank order |

---

## 5. Verification performed

| Check | Result |
|---|---|
| Subject `PRD-015_SEARCH_INDEXING.md` byte-unchanged | ✅ sha256 `fe3093e6…c2c4544` re-verified before and after |
| Any pre-existing repository statement of `N4`/`N6` order overwritten? | ⛔ **NO** — measured **0** existing order statements; `P2_ARCHITECTURE_DECISION` **§8.2** and `ADR-0100` **L70** both record it as unspecified |
| Any `Accepted` ADR's decision text overwritten? | ⛔ **NO** — `ADR-0099` and `ADR-0100` byte-unchanged, **not** superseded, **not** restatused |
| Unicode facts paraphrased into rules? | ⛔ **NO** — `Z1`…`Z8` are verbatim; each decision cites the specific fact it rests on |
| Frozen documents modified | ⛔ **0** |
| Application-code lines changed | ⛔ **0** |
| Baseline identifier moved | ⛔ **NO** — `BASELINE-2026-09-03-A` stands (§7 rule 4) |
| Stage conferred | ⛔ **NONE** |

---

## 6. Change log

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-04 | **Created.** ⭐⭐⭐ **Identifies UTS #10 (Unicode Collation Algorithm, 17.0.0 rev 53) as the applicable authority for `BC-23` normalization — the first citation of it in this repository (measured 0 prior hits) — on the ground that §16 is a *matching* rule set (`SRCH-FR-023`, `SRCH-BR-008`), and matching is UTS #10 §11's subject, whereas UAX #29 governs *segmentation* and UAX #31 governs *identifiers*.** ⭐⭐ **`D-8` closes the `N6`×`N4` ordering** — canonical normalization **before** format-character removal — read off §7.1 Step 1/S1.1 (*"Convert the string into Normalization Form D"*) and §11.1 (*"first converted to NFD, then…"*), with the precision that `N4` is a compound and only its canonical limb is ordered here. ⭐⭐ **`D-9` closes `ZWJ` (`U+200D`): NO exception — removal is correct**, on Appendix A.3.1 verbatim (*"the default UCA collation weighting causes the ZWJ to be—correctly—ignored in comparison, since it should only affect rendering"*); ⭐⭐⭐ **this REVERSES the direction a prior pass leaned from UAX #29, and the withdrawal is recorded rather than defended** — exclusion from `Grapheme_Cluster_Break=Control` governs boundary placement, not match significance. ⛔⛔ **`D-10` REFUSES `ZWNJ` (`U+200C`) for Devanagari** — UTS #10 names it in **0** treatment statements; §11.1 item 2 warns folding away an ignorable is *incorrect* where it interrupts a meaningful sequence; UAX #29 puts `ZWNJ` in `Extend` for **Bangla, Khmer, Malayalam, Odiya** and ⭐ **omits Devanagari**, the one script `SRCHPO-1` makes canonical; `SRCH-BR-008` cannot break the tie because both outcomes are symmetric; `SRCH-AC-024` is all-Latin so no AC exercises Devanagari. **Three falsifiable closure conditions are stated** and the residue is routed to **Architecture Owner + Product Owner** jointly. ⭐ **§3.2 records, as Enterprise Architect, that `MP-NFR-07`'s `Per-platform` Owner cell makes `BC-23` the Rank-1-assigned locus for its own latency budget**, so `ADR-0100` §3.3's component target sits correctly and the missing platform-wide document is **`PRD-023`'s** external blocker (`DOCUMENTATION_BASELINE.md` **L191**), ⛔ not a `PRD-015` deliverable; ⛔ **the EA is NOT edited** (`ADR-0079`). ⛔ **`SRCH-GAP-002` limb 7 is PARTIAL, not CLOSED — 2 of 3 sub-conjuncts; both gaps REMAIN OPEN.** ⛔ **Creates 0 engines, 0 analyzers, 0 tokenizers, 0 vendors, 0 field script values, 0 vocabulary entries, 0 NFR numbers, 0 corpus definitions, 0 owners, 0 offices, 0 APIs, 0 BCs, 0 edges, 0 events, 0 `IMPL-*`, 0 application-code files, and 0 invented Unicode rules.** ⛔ **Subject byte-unchanged; `ADR-0099`/`ADR-0100` byte-unchanged and NOT superseded; every frozen document untouched; baseline NOT moved; Stage 3 NOT CONFERRED; `PRD-015` still Stage 2 `DRAFT` / registry `PLANNED`.** |
